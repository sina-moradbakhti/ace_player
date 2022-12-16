import 'package:ace_player/blocs/playlist.bloc.dart';
import 'package:ace_player/components/playlist_item.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PlaylistPage extends StatelessWidget {
  PlaylistPage({super.key});

  final bloc = Get.put(PlaylistBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Playlists',
          style: AppTextStyles.headline2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: InkWell(
              onTap: bloc.create,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: Row(
                  children: [
                    const Icon(
                      Ionicons.add_outline,
                      color: Colors.black,
                      size: 21,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Create',
                      style: AppTextStyles.bold,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: bloc.repo.playlistStream,
          builder: (context, snapshot) {
            return bloc.repo.playlist.isNotEmpty ? _playlist : _emptyPlaylist;
          }),
    );
  }

  Widget get _playlist => Center(
          child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (context, index) =>
            PlayListItem(item: bloc.repo.playlist[index]),
        itemCount: bloc.repo.playlist.length,
      ));

  Widget get _emptyPlaylist => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: SvgPicture.asset(
              '031__list'.getSvgPath,
              color: AppColors.grey,
            ),
          ),
          Text(
            'No Playlist found!\nTap on + Create',
            textAlign: TextAlign.center,
            style: AppTextStyles.normal.copyWith(color: AppColors.grey),
          )
        ],
      ));
}
