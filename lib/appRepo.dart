import 'dart:convert';

import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/audio_player.dart';
import 'package:al_downloader/al_downloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:rxdart/rxdart.dart' as rxdart;

class AppRepo {
  static final AppRepo _singleton = AppRepo._internal();
  factory AppRepo() {
    return _singleton;
  }
  AppRepo._internal();

  final storage = GetStorage();
  final player = MyAudioPlayer();
  List<MusicModel> musics = [];
  List<String> playlist = [];
  bool darkMod = false;

  static final _playlistStreamController = rxdart.PublishSubject<bool>();
  final playlistStream = _playlistStreamController.stream;

  init() async {
    await GetStorage.init();
    ALDownloaderPrintConfig.enabled = false;
    darkMod = storage.read<bool>(AppConfigs.storageKeyDarkMod) ?? false;
    playlist = _getPlaylist();
    Get.changeThemeMode(darkMod ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> addPlaylist(String name) async {
    playlist = _getPlaylist();
    if (!playlist.contains(name)) {
      playlist.add(name);
      await storage.write(AppConfigs.storageKeyPlayLists, jsonEncode(playlist));
      _playlistStreamController.sink.add(true);
    }
  }

  Future<void> removePlaylist(String name) async {
    playlist = _getPlaylist();
    if (playlist.contains(name)) {
      playlist.removeWhere((element) => element == name);
      await storage.write(AppConfigs.storageKeyPlayLists, jsonEncode(playlist));
      _playlistStreamController.sink.add(true);
    }
  }

  List<String> _getPlaylist() {
    final json = storage.read<String>(AppConfigs.storageKeyPlayLists);
    if (json == null) return [];
    List<dynamic> list = jsonDecode(json);
    List<String> playlist = [];
    for (final item in list) {
      playlist.add(item);
    }
    return playlist;
  }

  String _idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }
}
