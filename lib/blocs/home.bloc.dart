import 'dart:io';

import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:id3/id3.dart';

class HomeBloc extends BlocBase {
  var updateList = true.obs;

  // File Picker
  final filePicker = FilePicker.platform;

  // Audio Player
  var currentMusicPath = ''.obs;
  final player = AudioPlayer();

  List<MusicModel> musics = [];

  final pageController = PageController(initialPage: -1);

  void play(MusicModel music) async {
    if (player.playing && music.path != currentMusicPath.value) {
      player.stop();
      currentMusicPath.value = music.path;
    }

    player.setFilePath(music.path);
    try {
      currentMusicPath.value = music.path;
      await player.play();
    } catch (er) {
      print(er);
    }
  }

  void pause() {
    player.pause();
    currentMusicPath.value = '';
  }

  void stop() {
    player.stop();
    currentMusicPath.value = '';
  }

  void import() async {
    final result = await filePicker.pickFiles(allowMultiple: true);
    for (final file in result?.files ?? []) {
      List<int> mp3Bytes = await File(file.path).readAsBytes();
      MP3Instance mp3instance = MP3Instance(mp3Bytes);
      final metaDataExtra = await MetadataRetriever.fromFile(File(file.path));
      if (mp3instance.parseTagsSync()) {
        final json = mp3instance.getMetaTags() ?? {};
        json['path'] = file.path;
        json['filename'] = file.name;
        json['duration'] = ((metaDataExtra.trackDuration ?? 0) / 1000).ceil();
        musics.add(MusicModel.fromJson(json));
      }
    }
    updateList.value = !updateList.value;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
