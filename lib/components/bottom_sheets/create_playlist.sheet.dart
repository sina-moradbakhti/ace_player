import 'package:ace_player/components/bottom_sheets/bottom_sheet_base.widget.dart';
import 'package:ace_player/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CreatePlaylistBottomSheet extends StatelessWidget {
  final Function(String, String)? onDownloadedMusic;
  CreatePlaylistBottomSheet({super.key, this.onDownloadedMusic});

  @override
  Widget build(BuildContext context) {
    return BottomSheetBaseContainer(
        title: 'Create Playlist',
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
                    hintText: 'e.g. Car',
                    labelText: 'Playlist name'),
              ),
            ),
            const SizedBox(width: 10),
            PrimaryButton(
              title: 'Add',
              icon: const Icon(
                Ionicons.add_outline,
                size: 20,
              ),
              onPressed: () {},
            )
          ],
        ));
  }
}
