import 'dart:convert';

import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
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
          itemBuilder: (context, index) => Obx(() => ElevatedButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () =>
                    bloc.currentMusicPath.value == bloc.musics[index].path
                        ? bloc.pause()
                        : bloc.play(bloc.musics[index]),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Stack(
                          children: [
                            CachedMemoryImage(
                                uniqueKey: bloc.musics[index].path,
                                base64:
                                    bloc.musics[index].apic?.base64Data ?? ''),
                            Center(
                              child: bloc.currentMusicPath.value ==
                                      bloc.musics[index].path
                                  ? const Icon(Icons.pause_rounded)
                                  : const Icon(Icons.play_arrow_rounded),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        bloc.musics[index].title ?? '',
                        style: AppTextStyles.normal,
                      ),
                    ),
                  ],
                ),
              )),
          itemCount: bloc.musics.length,
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
