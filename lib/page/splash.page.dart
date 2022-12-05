import 'dart:io';

import 'package:ace_player/blocs/splash.bloc.dart';
import 'package:ace_player/configs.dart';
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
            Center(
              child: Image.asset('assets/images/png/default-album-art.png'),
            ),
            Text(
              'Ace Player',
              style: AppTextStyles.headline1,
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
