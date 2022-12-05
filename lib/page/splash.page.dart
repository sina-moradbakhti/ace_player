import 'dart:io';

import 'package:ace_player/blocs/splash.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final bloc = Get.put(SplashBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.size.width,
        height: Get.size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('icon_purple_play'.getPngPath)),
                const SizedBox(height: 30),
                Text(
                  'Ace Player',
                  style: AppTextStyles.headline1,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                  child: Text(
                'v: ${AppConfigs.version}',
                style: AppTextStyles.caption3,
              )),
            )
          ],
        ),
      ),
    );
  }
}
