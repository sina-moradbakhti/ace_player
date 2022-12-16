import 'dart:convert';
import 'dart:io';

import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/components/bottom_sheets/download_music.sheet.dart';
import 'package:ace_player/components/bottom_sheets/music_import.sheet.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/apic.model.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:id3/id3.dart';

class MusicsBloc extends BlocBase {
  var updateList = true.obs;
  var pickingFiles = false.obs;

  Directory? appDocDir;
  String? appDocPath;

  // File Picker
  final filePicker = FilePicker.platform;

  void import() async {
    Get.bottomSheet(MusicImportBottomSheet(
      onTappedFromFile: _importFromPicker,
      onTappedFromClipboard: _importFromClipboardBottomsheet,
    ));
  }

  void _importFromClipboardBottomsheet() {
    Get.bottomSheet(DownloadMusicBottomSheet(
        onDownloadedMusic: (newMusicPath, filename) =>
            _importFromClipboard(newMusicPath, filename)));
  }

  void _importFromClipboard(var file, var filename) async {
    final metaData = await _getMetaData(file, isPath: true, filename: filename);
    if (metaData != null) {
      final exist = repo.musics
          .where((element) => file.toString().contains(element.filename))
          .toList();
      if (exist.isEmpty) {
        final apic = metaData['APIC'] == null
            ? null
            : ApicModel.fromJson(metaData['APIC']);
        final musicArtFilePath =
            '$appDocPath/al_flutter/al_audio/${metaData['filename']}.jpg';
        if (apic != null) {
          await File(musicArtFilePath)
              .writeAsBytes(const Base64Decoder().convert(apic.base64Data));
        }

        _addMusicToMusics(metaData);
        updateList.value = !updateList.value;

        closeBottomSheet();
        await Future.delayed(const Duration(milliseconds: 200));
        closeBottomSheet();
      } else {
        showError('This music already added into list!');
      }
    }
  }

  void _importFromPicker() async {
    try {
      final result = await filePicker.pickFiles(
          allowMultiple: true,
          allowedExtensions: ['mp3'],
          type: FileType.custom);
      pickingFiles.value = true;
      for (PlatformFile file in result?.files ?? []) {
        final metaData = await _getMetaData(file);
        if (metaData != null) {
          final exist = repo.musics
              .where((element) => element.path.contains(file.name))
              .toList();
          if (exist.isEmpty) {
            _addMusicToMusics(metaData);
            updateList.value = !updateList.value;
            closeBottomSheet();
          } else {
            showError('This music already added into the list!');
          }
        }
      }
      pickingFiles.value = false;
    } catch (er) {
      print(er);
    }
  }

  _addMusicToMusics(var metaData) async {
    repo.musics.add(MusicModel.fromJson(metaData));
    await repo.storage.write(AppConfigs.storageKeyMusics,
        json.encode([for (final music in repo.musics) music.toJson()]));
  }

  Future<Map<String, dynamic>?> _getMetaData(var file,
      {bool isPath = false, String? filename}) async {
    List<int> mp3Bytes = !isPath
        ? await File(file.path).readAsBytes()
        : await File(file).readAsBytes();
    MP3Instance mp3instance = MP3Instance(mp3Bytes);
    final metaDataExtra = await MetadataRetriever.fromFile(
        !isPath ? File(file.path) : File(file));

    if (mp3instance.parseTagsSync()) {
      final json = mp3instance.getMetaTags() ?? {};

      json['filename'] = !isPath ? file.name : filename;
      json['duration'] = ((metaDataExtra.trackDuration ?? 0) / 1000).ceil();

      final apic =
          json['APIC'] == null ? null : ApicModel.fromJson(json['APIC']);

      if (!isPath) {
        final musicFilePath = '$appDocPath/${json['filename']}';
        final musicArtFilePath = '$appDocPath/${json['filename']}.jpg';
        if (apic != null) {
          await File(musicArtFilePath)
              .writeAsBytes(const Base64Decoder().convert(apic.base64Data));
        }

        await File(musicFilePath).writeAsBytes(mp3Bytes);
        json['path'] = musicFilePath;
      } else {
        json['path'] = !isPath ? file.path : file;
      }

      return json;
    }
    return null;
  }

  _initDir() async {
    appDocDir = await pp.getApplicationDocumentsDirectory();
    appDocPath = appDocDir!.path;
  }

  @override
  void onInit() {
    _initDir();
    super.onInit();
  }
}
