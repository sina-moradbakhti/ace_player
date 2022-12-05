import 'dart:io';

import 'package:ace_player/models/music.model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MyAudioPlayer {
  static final MyAudioPlayer _singleton = MyAudioPlayer._internal();
  factory MyAudioPlayer() {
    return _singleton;
  }
  MyAudioPlayer._internal();

  final player = AssetsAudioPlayer();
  MusicModel? currentMusic;

  void play(MusicModel music) async {
    if (player.isPlaying.value && currentMusic?.path != music.path) {
      await player.stop();
      currentMusic = music;
      _newPlay(music);
    } else if (!player.isPlaying.value && currentMusic?.path == music.path) {
      await player.play();
    } else {
      await _newPlay(music);
    }
  }

  Future<void> _newPlay(MusicModel music) async {
    currentMusic = music;
    try {
      await player.open(
          Audio.file(music.path,
              metas: Metas(
                  title: music.title ?? '',
                  artist: music.artist ?? '',
                  album: music.album ?? '',
                  image: MetasImage.file('${music.path}.jpg'),
                  onImageLoadFail: const MetasImage.network(
                      'https://songdewnetwork.com/sgmedia/assets/images/default-album-art.png'))),
          showNotification: true,
          notificationSettings: const NotificationSettings(
            playPauseEnabled: true,
            nextEnabled: true,
            seekBarEnabled: true,
            prevEnabled: true,
            stopEnabled: true,
          ));
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
