import 'package:ace_player/blocs/musics.bloc.dart';
import 'package:ace_player/components/music_item.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MusicsPage extends StatelessWidget {
  MusicsPage({super.key});
  final bloc = Get.put(MusicsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Musics',
          style: AppTextStyles.headline2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: InkWell(
              onTap: bloc.import,
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
                      'Import',
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
        stream: bloc.updateList.stream,
        builder: (context, snapshot) => StreamBuilder(
          stream: bloc.repo.player.player.playerState,
          builder: (context, snapshot) {
            return bloc.repo.musics.isNotEmpty ? _myList : _emptyMusics;
          },
        ),
      ),
    );
  }

  Widget get _myList => ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) =>
            MusicItem(music: bloc.repo.musics[index]),
        itemCount: bloc.repo.musics.length,
        separatorBuilder: (context, index) => const Divider(),
      );

  Widget get _emptyMusics => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.headset_outline,
            size: 50,
            color: AppColors.grey,
          ),
          const SizedBox(height: 15),
          Text(
            'No Musics found!\nTap on + Import',
            textAlign: TextAlign.center,
            style: AppTextStyles.normal.copyWith(color: AppColors.grey),
          )
        ],
      ));
}
