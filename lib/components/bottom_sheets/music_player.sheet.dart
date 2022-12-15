import 'package:ace_player/appRepo.dart';
import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MusicPlayerBottomSheet extends StatelessWidget {
  MusicPlayerBottomSheet({super.key});

  final repo = AppRepo();
  MusicModel? get _musicModel => repo.player.currentMusic;
  final bloc = Get.find<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    final totalSec = (bloc.repo.player.currentMusic?.duration ?? 1);

    return StreamBuilder<Duration>(
        stream: bloc.repo.player.player.currentPosition,
        builder: (context, snapshot) {
          return BottomSheetBaseContainer(
              player: true,
              child: Stack(
                children: [
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Icon(
                          CupertinoIcons.suit_heart_fill,
                          size: 28,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    // height: 300,
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.size.width / 1.5,
                          height: Get.size.width / 1.5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Get.size.width / 1.5),
                                child: _musicModel?.apic == null
                                    ? Image.asset(
                                        'assets/images/png/default-album-art.png')
                                    : CachedMemoryImage(
                                        uniqueKey: _musicModel!.path,
                                        base64:
                                            _musicModel?.apic?.base64Data ?? '',
                                      ),
                              ),
                              SizedBox(
                                width: (Get.size.width / 1.5),
                                height: (Get.size.width / 1.5),
                                child: SleekCircularSlider(
                                  initialValue:
                                      (((snapshot.data?.inSeconds ?? 0) * 100) /
                                          totalSec),
                                  min: 0,
                                  max: 100,
                                  onChange: (value) => bloc.repo.player.player
                                      .seek(Duration(
                                          seconds: ((totalSec * value) / 100)
                                              .ceil())),
                                  innerWidget: (_) => Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Get.theme.primaryColor),
                                          child: Text(
                                            (snapshot.data?.inSeconds ?? 0)
                                                .toDuration(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700),
                                          ))
                                    ],
                                  ),
                                  appearance: CircularSliderAppearance(
                                      customColors: CustomSliderColors(
                                          dynamicGradient: false,
                                          trackColor: Colors.white,
                                          progressBarColors: [
                                        Get.theme.primaryColor,
                                        Colors.greenAccent,
                                        Get.theme.primaryColor,
                                      ],
                                          trackColors: [
                                        Colors.white.withOpacity(0.3),
                                        Colors.white.withOpacity(0.6)
                                      ])),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: _suffle,
                                ),
                                const SizedBox(width: 15),
                                _prevBtn,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 7.5)
                                      .copyWith(top: 15),
                                  child: _playBtn,
                                ),
                                _nextBtn,
                                const SizedBox(width: 15),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: _repeat,
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                bloc.repo.player.currentMusic?.artist ?? '',
                                style: AppTextStyles.headline4,
                              ),
                              Text(
                                bloc.repo.player.currentMusic?.title ?? '',
                                style: AppTextStyles.caption2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Widget get _playBtn => StreamBuilder<PlayerState>(
        stream: bloc.repo.player.player.playerState,
        builder: (context, snapshot) => InkWell(
            onTap: snapshot.data != PlayerState.pause
                ? bloc.repo.player.pause
                : () => bloc.repo.player.play(_musicModel!),
            child: CircleAvatar(
              radius: 29,
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

  Widget get _suffle => InkWell(
      onTap: () => bloc.repo.player.player.toggleShuffle(),
      child: StreamBuilder<bool>(
          stream: bloc.repo.player.player.isShuffling,
          builder: (context, snapshot) {
            return CircleAvatar(
              radius: 16,
              backgroundColor: (snapshot.data ?? false)
                  ? AppColors.mainBlue
                  : AppColors.grey,
              child: Icon(
                CupertinoIcons.shuffle,
                size: 17,
                color: Get.theme.buttonTheme.colorScheme?.onPrimary,
              ),
            );
          }));

  Widget get _repeat => InkWell(
      onTap: () => bloc.repo.player.player.loopMode.value == LoopMode.none
          ? bloc.repo.player.player.setLoopMode(LoopMode.single)
          : bloc.repo.player.player.setLoopMode(LoopMode.none),
      child: StreamBuilder<LoopMode>(
          stream: bloc.repo.player.player.loopMode,
          builder: (context, snapshot) {
            return CircleAvatar(
              radius: 16,
              backgroundColor: (snapshot.data == LoopMode.none)
                  ? AppColors.grey
                  : AppColors.mainGreen,
              child: Icon(
                CupertinoIcons.repeat,
                size: 17,
                color: Get.theme.buttonTheme.colorScheme?.onPrimary,
              ),
            );
          }));

  Widget get _nextBtn => InkWell(
      onTap: () => bloc.repo.player.next(),
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '136__next'.getSvgPath,
          width: 50,
          height: 50,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));

  Widget get _prevBtn => InkWell(
      onTap: () => bloc.repo.player.previous(),
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset('137__previous'.getSvgPath,
            width: 50,
            height: 50,
            color: Get.theme.buttonTheme.colorScheme?.onPrimary),
      ));
}
