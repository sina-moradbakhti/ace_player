import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

class PlanetPage extends StatelessWidget {
  const PlanetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Planet Community',
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
                    SvgPicture.asset('103__user'.getSvgPath),
                    Text(
                      'Login',
                      style: AppTextStyles.bold,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: _emptyPlaylist,
    );
  }

  Widget get _emptyPlaylist => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: SvgPicture.asset(
              '072__planet'.getSvgPath,
              color: AppColors.grey,
            ),
          ),
          Text(
            'A friendly place for sharing your interests\nand find your memorable songs!\n\nComing soon',
            textAlign: TextAlign.center,
            style: AppTextStyles.normal.copyWith(color: AppColors.grey),
          )
        ],
      ));
}
