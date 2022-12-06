import 'package:ace_player/appRepo.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ace_player/utils/ext.dart';

class MusicItem extends StatelessWidget {
  final repo = AppRepo();

  final MusicModel music;
  MusicItem({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => (repo.player.player.isPlaying.value &&
              music.path == repo.player.currentMusic?.path)
          ? repo.player.pause(music)
          : repo.player.play(music),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: 45,
                height: 45,
                child: Stack(
                  children: [
                    CachedMemoryImage(
                        uniqueKey: music.path,
                        base64: music.apic?.base64Data ?? ''),
                    Center(
                      child: (repo.player.player.isPlaying.value &&
                              music.path == repo.player.currentMusic?.path)
                          ? const Icon(Ionicons.pause_outline,
                              color: Colors.white)
                          : const Icon(
                              Ionicons.play_outline,
                              color: Colors.white,
                            ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              music.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.normal,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              music.duration.toDuration(),
                              textAlign: TextAlign.right,
                              style: AppTextStyles.caption3,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 2.5),
                      SizedBox(
                          width: double.infinity,
                          child: Text(
                            music.artist ?? '',
                            style: AppTextStyles.caption2,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
