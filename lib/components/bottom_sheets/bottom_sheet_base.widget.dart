import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class BottomSheetBaseContainer extends StatelessWidget {
  final Widget child;
  String? title;
  final bool player;
  BottomSheetBaseContainer(
      {super.key, required this.child, this.title, this.player = false});

  @override
  Widget build(BuildContext context) {
    return player ? _playerContent : _content;
  }

  Widget get _content => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.headline3,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(),
                ),
                child
              ],
            ),
          ),
        ),
      );

  Widget get _playerContent => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: child,
      );
}
