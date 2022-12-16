import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/components/bottom_sheets/create_playlist.sheet.dart';
import 'package:get/get.dart';

class PlaylistBloc extends BlocBase {
  var playlistName = ''.obs;

  void create() async {
    Get.bottomSheet(CreatePlaylistBottomSheet());
  }

  void add() {
    if (playlistName.value.isEmpty) {
      showError('Please enter your playlist name!');
      return;
    }
    repo.addPlaylist(playlistName.value);
    closeBottomSheet();
  }
}
