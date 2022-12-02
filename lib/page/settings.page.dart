import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Settings',
          style: AppTextStyles.headline2,
        ),
      ),
    );
  }
}
