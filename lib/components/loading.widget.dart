import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? stroke;

  const MyLoading({super.key, this.color, this.size, this.stroke});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 20,
      height: size ?? 20,
      child: CircularProgressIndicator(
        color: color ?? AppColors.mainBlue,
        strokeWidth: stroke ?? 3,
      ),
    );
  }
}
