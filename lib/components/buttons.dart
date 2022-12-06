import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final VoidCallback? onPressed;
  const PrimaryButton(
      {super.key, required this.title, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(width: 1, color: Get.theme.primaryColor)),
          foregroundColor:
              MaterialStateProperty.all<Color>(Get.theme.primaryColor),
          elevation: MaterialStateProperty.all<double>(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [icon!, const SizedBox(width: 5), _txt],
              )
            : _txt,
      ),
    );
  }

  Widget get _txt => Text(
        title,
        style: AppTextStyles.button.copyWith(color: Get.theme.primaryColor),
      );
}
