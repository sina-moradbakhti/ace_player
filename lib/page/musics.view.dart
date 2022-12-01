import 'package:ace_player/blocs/home.bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicsView extends StatelessWidget {
  MusicsView({super.key});

  final bloc = Get.find<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: StreamBuilder(
        stream: bloc.updateList.stream,
        builder: (context, snapshot) => ListView.separated(
          itemBuilder: (context, index) => Container(
            child: Obx(() => Row(
                  children: [
                    bloc.currentIndexPlaying.value.toString() ==
                            index.toString()
                        ? IconButton(
                            onPressed: () => bloc.pause(),
                            icon: const Icon(Icons.pause_rounded))
                        : IconButton(
                            onPressed: () => bloc.listenMusic(index),
                            icon: const Icon(Icons.play_arrow_rounded)),
                    Text(bloc.musicList[index]['name'] ?? ''),
                  ],
                )),
          ),
          itemCount: bloc.musicList.length,
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
