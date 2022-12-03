import 'dart:convert';

import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/routes.dart';
import 'package:get/get.dart';

class SplashBloc extends BlocBase {
  final int SPLASH_TIME = 3;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() async {
    await Future.delayed(Duration(seconds: SPLASH_TIME));

    final jsonData = repo.storage.read<String>(AppConfigs.storageKeyMusics);
    if (jsonData != null) {
      for (final item in json.decode(jsonData)) {
        repo.musics.add(MusicModel.fromJson(item));
      }
    }

    Get.offAllNamed(AppRoutes.main);
  }
}
