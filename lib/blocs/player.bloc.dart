import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/models/music.model.dart';

class PlayerBloc extends BlocBase {
  MusicModel get _musicModel => repo.musics.last;
}
