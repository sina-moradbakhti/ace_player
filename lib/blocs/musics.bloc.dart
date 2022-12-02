import 'dart:io';

import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/components/bottom_sheets/download_music.sheet.dart';
import 'package:ace_player/components/bottom_sheets/music_import.sheet.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:id3/id3.dart';

class MusicsBloc extends BlocBase {
  var updateList = true.obs;
  var downloadProgress = 0.obs;

  // File Picker
  final filePicker = FilePicker.platform;

  void import() async {
    Get.bottomSheet(MusicImportBottomSheet(
      onTappedFromFile: _importFromPicker,
      onTappedFromClipboard: _importFromClipboardBottomsheet,
    ));
  }

  void _importFromClipboardBottomsheet() {
    downloadProgress.value = 0;
    Get.bottomSheet(DownloadMusicBottomSheet());
    _importFromClipboardAndDownload();
  }

  void _importFromClipboardAndDownload() async {
    for (int i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      downloadProgress.value += 1;
    }
    await Future.delayed(const Duration(seconds: 1));
    closeBottomSheet();
  }

  void _importFromPicker() async {
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
        repo.musics.add(MusicModel.fromJson(json));
      }
      updateList.value = !updateList.value;
    }
    closeBottomSheet();
  }
}
