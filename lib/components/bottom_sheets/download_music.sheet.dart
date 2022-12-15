import 'package:ace_player/blocs/download.bloc.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/components/loading.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/models/dl_status.enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class DownloadMusicBottomSheet extends StatelessWidget {
  final Function(String, String)? onDownloadedMusic;
  DownloadMusicBottomSheet({super.key, this.onDownloadedMusic});

  final bloc = Get.put(DownloadBloc());

  @override
  Widget build(BuildContext context) {
    return BottomSheetBaseContainer(
        title: 'Download Music',
        child: Obx(
          () {
            if (onDownloadedMusic != null &&
                bloc.downloadStatus.value == DownloadStatus.successed &&
                !bloc.sentToPreviousPage &&
                bloc.downloadedFile != null) {
              bloc.sentToPreviousPage = true;
              onDownloadedMusic!(
                  bloc.downloadedFile!, bloc.downloadedFilename ?? '');
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  bloc.downloadStatus.value == DownloadStatus.downloading ||
                          bloc.downloadStatus.value == DownloadStatus.successed
                      ? (bloc.downloadProgress.value >= 100
                          ? const Icon(
                              Ionicons.checkmark_circle_outline,
                              size: 30,
                            )
                          : const MyLoading())
                      : const Icon(
                          Ionicons.close_circle_outline,
                          size: 30,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (bloc.downloadStatus.value == DownloadStatus.successed)
                    Text(
                      'Download Completed',
                      style: AppTextStyles.normal,
                    ),
                  if (bloc.downloadStatus.value == DownloadStatus.failed)
                    Text(
                      'Download Failed!',
                      style: AppTextStyles.normal,
                    ),
                  if (bloc.downloadStatus.value == DownloadStatus.downloading)
                    Text(
                      'Downloading ... ${bloc.downloadProgress.value}%',
                      style: AppTextStyles.normal,
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
