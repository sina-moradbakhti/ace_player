import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MiniPlayerWidget extends StatelessWidget {
  MiniPlayerWidget({super.key});

  final bloc = Get.find<HomeBloc>();
  final double _HEIGHT = 80;

  MusicModel get _musicModel => bloc.repo.musics.last;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: _HEIGHT,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2.5),
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
                          child: CachedMemoryImage(
                            uniqueKey: _musicModel.path,
                            base64: _musicModel.apic?.base64Data ?? '',
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
                            _musicModel.title ?? '',
                            style: AppTextStyles.headline4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _musicModel.artist ?? '',
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
                                Text(
                                  _musicModel.duration.toDuration(),
                                  style: AppTextStyles.caption3,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
      ),
    );
  }

  Widget get _playBtn => InkWell(
      onTap: () {},
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '131__play'.getSvgPath,
          width: 120,
          height: 120,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));

  Widget get _nextBtn => InkWell(
      onTap: () {},
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '134__fast forward'.getSvgPath,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));

  Widget get _prevBtn => InkWell(
      onTap: () {},
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Get.theme.primaryColor,
        child: SvgPicture.asset(
          '135__rewind'.getSvgPath,
          color: Get.theme.buttonTheme.colorScheme?.onPrimary,
        ),
      ));
}
