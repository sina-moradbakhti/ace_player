import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/audio_player.dart';
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
}
