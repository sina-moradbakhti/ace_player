import 'package:ace_player/blocs/musics.bloc.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/components/loading.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class DownloadMusicBottomSheet extends StatelessWidget {
  DownloadMusicBottomSheet({super.key});

  final bloc = Get.find<MusicsBloc>();

  @override
  Widget build(BuildContext context) {
    return BottomSheetBaseContainer(
        title: 'Download Music',
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              bloc.downloadProgress.value >= 100
                  ? const Icon(
                      Ionicons.checkmark_circle_outline,
                      size: 30,
                    )
                  : const MyLoading(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Downloading ... ${bloc.downloadProgress.value}%',
                style: AppTextStyles.normal,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
