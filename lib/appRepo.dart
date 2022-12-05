import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/audio_player.dart';
import 'package:al_downloader/al_downloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppRepo {
  static final AppRepo _singleton = AppRepo._internal();
  factory AppRepo() {
    return _singleton;
  }
  AppRepo._internal();

  final storage = GetStorage();
  final player = MyAudioPlayer();
  List<MusicModel> musics = [];
  bool darkMod = false;

  init() async {
    await GetStorage.init();
    ALDownloaderPrintConfig.enabled = false;
    darkMod = storage.read<bool>(AppConfigs.storageKeyDarkMod) ?? false;
    Get.changeThemeMode(darkMod ? ThemeMode.dark : ThemeMode.light);
  }
}
