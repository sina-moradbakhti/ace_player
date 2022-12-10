import 'package:ace_player/appRepo.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/components/buttons.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/music.model.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MusicPlayerBottomSheet extends StatelessWidget {
  MusicPlayerBottomSheet({super.key});

  final repo = AppRepo();
  MusicModel? get _musicModel => repo.player.currentMusic;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBaseContainer(
        player: true,
        child: Container(
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
                      borderRadius: BorderRadius.circular(Get.size.width / 1.5),
                      child: CachedMemoryImage(
                        uniqueKey: _musicModel!.path,
                        base64: _musicModel?.apic?.base64Data ?? '',
                      ),
                    ),
                    SizedBox(
                      width: (Get.size.width / 1.5),
                      height: (Get.size.width / 1.5),
                      child: SleekCircularSlider(
                        min: 0,
                        max: 100,
                        onChange: (value) {
                          print(value);
                        },
                        innerWidget: (_) => Container(),
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
              )
            ],
          ),
        ));
  }
}
