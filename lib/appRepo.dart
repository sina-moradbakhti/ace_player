import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/audio_player.dart';

class AppRepo {
  static final AppRepo _singleton = AppRepo._internal();
  factory AppRepo() {
    return _singleton;
  }
  AppRepo._internal();

  final player = MyAudioPlayer();
  List<MusicModel> musics = [];
}
