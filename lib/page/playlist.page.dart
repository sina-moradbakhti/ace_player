import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Playlists',
          style: AppTextStyles.headline2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: InkWell(
              // onTap: bloc.create,
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.5),
                child: Row(
                  children: [
                    const Icon(
                      Ionicons.add_outline,
                      color: Colors.black,
                      size: 21,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Create',
                      style: AppTextStyles.bold,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
