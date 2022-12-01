import 'dart:io';

import 'package:ace_player/blocs/base.bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:id3/id3.dart';

class HomeBloc extends BlocBase {
  var updateList = true.obs;

  // File Picker
  final filePicker = FilePicker.platform;

  // Audio Player
  var currentIndexPlaying = ''.obs;
  final player = AudioPlayer();

  List<Map<String, String>> musicList = [];

  final pageController = PageController(initialPage: -1);

  void pause() {
    if (player.playing) {
      player.pause();
      currentIndexPlaying.value = '';
      return;
    }
  }

  void listenMusic(int musicIndex) async {
    if (player.playing) {
      player.stop();
      currentIndexPlaying.value = '';
      return;
    }
    // await player.setSourceUrl(musicList[musicIndex]);
    player.setFilePath(musicList[musicIndex]['link']!);
    try {
      currentIndexPlaying.value = musicIndex.toString();
      await player.play();
      print('Duration: ${player.duration?.inSeconds} seconds');

      List<int> mp3Bytes =
          await File(musicList[musicIndex]['link']!).readAsBytes();
      MP3Instance mp3instance = MP3Instance(mp3Bytes);
      if (mp3instance.parseTagsSync()) {
        print(mp3instance.getMetaTags());
      }
    } catch (er) {
      print(er);
    }
  }

  void import() async {
    final result = await filePicker.pickFiles(allowMultiple: true);
    for (final file in result?.files ?? []) {
      musicList.add({'link': file.path, 'name': file.name});
    }
    updateList.value = !updateList.value;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
