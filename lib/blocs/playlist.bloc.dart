import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/components/bottom_sheets/create_playlist.sheet.dart';
import 'package:get/get.dart';

class PlaylistBloc extends BlocBase {
  void create() async {
    Get.bottomSheet(CreatePlaylistBottomSheet());
  }
}
