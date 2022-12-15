import 'package:ace_player/blocs/musics.bloc.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/components/bottom_sheets/bottom_sheet_item.widget.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MusicImportBottomSheet extends StatelessWidget {
  final VoidCallback? onTappedFromFile;
  final VoidCallback? onTappedFromClipboard;

  MusicImportBottomSheet(
      {super.key, this.onTappedFromClipboard, this.onTappedFromFile});

  final bloc = Get.find<MusicsBloc>();

  @override
  Widget build(BuildContext context) {
    return BottomSheetBaseContainer(
      title: 'Import Musics',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => BottomSheetItemButton(
              title: 'From Files',
              icon: const Icon(Ionicons.folder_open_outline),
              onTapped: onTappedFromFile,
              loading: bloc.pickingFiles.value,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BottomSheetItemButton(
            title: 'From Clipboard (Download)',
            icon: const Icon(Ionicons.cloud_outline),
            onTapped: onTappedFromClipboard,
          ),
          const SizedBox(
            height: 30,
          ),
          BottomSheetItemButton(
            title: 'From Spottify',
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('icon_spottify'.getPngPath),
            ),
            onTapped: null,
          ),
          //
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
