import 'package:ace_player/models/music.model.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioPlayer {
  static final MyAudioPlayer _singleton = MyAudioPlayer._internal();
  factory MyAudioPlayer() {
    return _singleton;
  }
  MyAudioPlayer._internal();

  final player = AudioPlayer();
  MusicModel? currentMusic;

  void play(MusicModel music) async {
    if (player.playing && currentMusic?.path != music.path) {
      await player.stop();
      currentMusic = music;
      _newPlay(music);
    } else if (!player.playing && currentMusic?.path == music.path) {
      await player.play();
    } else {
      await _newPlay(music);
    }
  }

  Future<void> _newPlay(MusicModel music) async {
    player.setFilePath(music.path);
    try {
      currentMusic = music;
      await player.play();
    } catch (er) {
      print(er);
    }
  }

  void pause(MusicModel music) async {
    await player.pause();
  }

  void stop() async {
    player.stop();
    currentMusic = null;
  }
}
