import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/components/bottom_sheets/music_player.sheet.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MiniPlayerWidget extends StatelessWidget {
  MiniPlayerWidget({super.key});

  final bloc = Get.find<HomeBloc>();
  final double _HEIGHT = 80;

  MusicModel? get _musicModel => bloc.repo.player.currentMusic;

  @override
  Widget build(BuildContext context) {
    if (_musicModel == null) return Container();
    return InkWell(
      onTap: _openPlayer,
      child: Container(
        height: _HEIGHT,
        color: Colors.grey.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 2.5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          SizedBox(
                            width: _HEIGHT - 10,
                            height: _HEIGHT - 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: _musicModel?.apic == null
                                  ? Image.asset(
                                      'assets/images/png/default-album-art.png')
                                  : CachedMemoryImage(
                                      uniqueKey: _musicModel!.path,
                                      base64:
                                          _musicModel?.apic?.base64Data ?? '',
                                    ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _musicModel?.title ?? '',
                                style: AppTextStyles.headline4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _musicModel?.artist ?? '',
                                style: AppTextStyles.caption2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 7.5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        CupertinoIcons.suit_heart_fill,
                                        size: 13,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                    StreamBuilder<Duration>(
                                        stream: bloc
                                            .repo.player.player.currentPosition,
                                        builder: (context, snapshot) => Text(
                                              (snapshot.data?.inSeconds ?? 0)
                                                  .toDuration(),
                                              style: AppTextStyles.caption3,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                  ],
                                ),
                              )
                            ],
                          ))
                        ],
                      )),
                      SizedBox(
                        width: Get.size.width / 3,
                        height: _HEIGHT - 10,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _prevBtn,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7.5),
                                child: _playBtn,
                              ),
                              _nextBtn
                            ]),
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder<Duration>(
                stream: bloc.repo.player.player.currentPosition,
                builder: (context, snapshot) {
                  final val =
                      (snapshot.data?.inSeconds ?? 0) / _musicModel!.duration;

                  return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: val),
                      duration: const Duration(milliseconds: 2000),
                      builder: (context, value, child) =>
                          LinearProgressIndicator(
                            minHeight: 2,
                            value: value,
                          ));
                })
          ],
        ),
      ),
    );
  }

  Widget get _playBtn => StreamBuilder<PlayerState>(
        stream: bloc.repo.player.player.playerState,
        builder: (context, snapshot) => InkWell(
            onTap: snapshot.data != PlayerState.pause
                ? bloc.repo.player.pause
                : () => bloc.repo.player.play(_musicModel!),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Get.theme.primaryColor,
              child: SvgPicture.asset(
                (snapshot.data != PlayerState.pause
                        ? '132__pause'
                        : '131__play')
                    .getSvgPath,
                width: 120,
                height: 120,
                color: Get.theme.buttonTheme.colorScheme?.onPrimary,
              ),
            )),
      );

  Widget get _nextBtn => InkWell(
      onTap: () => bloc.repo.player.next(),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '136__next'.getSvgPath,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));

  Widget get _prevBtn => InkWell(
      onTap: () => bloc.repo.player.previous(),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '137__previous'.getSvgPath,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));

  void _openPlayer() {
    Get.bottomSheet(MusicPlayerBottomSheet(),
        barrierColor: Colors.black45,
        exitBottomSheetDuration: const Duration(milliseconds: 150),
        enterBottomSheetDuration: const Duration(milliseconds: 150));
  }
}
