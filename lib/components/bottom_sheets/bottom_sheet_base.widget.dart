import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class BottomSheetBaseContainer extends StatelessWidget {
  final Widget child;
  final String title;
  const BottomSheetBaseContainer(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                title,
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
  }
}
