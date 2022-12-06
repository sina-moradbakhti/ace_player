import 'package:ace_player/blocs/settings.bloc.dart';
import 'package:ace_player/components/settings_item.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final bloc = Get.put(SettingsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTextStyles.headline2,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Obx(() => SettingsItem(
                  title: 'Enable dark mod',
                  hasSwitch: true,
                  switchOn: bloc.darkMod.value,
                  icon: SvgPicture.asset('167__moon'.getSvgPath),
                  onTapped: bloc.toggleTheme,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 15, top: 30),
              child: Text(
                'Generals',
                textAlign: TextAlign.left,
                style: AppTextStyles.headline4,
              ),
            ),
            SettingsItem(
              title: 'Help',
              icon: SvgPicture.asset('060__life buoy'.getSvgPath),
              onTapped: bloc.help,
            ),
            SettingsItem(
              title: 'Report bug',
              icon: SvgPicture.asset('073__focus'.getSvgPath),
              onTapped: bloc.reportBug,
            ),
            SettingsItem(
              title: 'Rate & review our app',
              icon: SvgPicture.asset('146__star'.getSvgPath),
              onTapped: bloc.rateReview,
            ),
            SettingsItem(
              title: 'Buy me a coffe',
              icon: SvgPicture.asset('155__coffe_tea'.getSvgPath),
              onTapped: bloc.buyMeCoffe,
            ),
            SettingsItem(
              title: 'Terms & condition',
              icon: SvgPicture.asset('034__text'.getSvgPath),
              onTapped: bloc.termsCondition,
            ),
            SettingsItem(
              title: 'Privacy Policy',
              icon: SvgPicture.asset('043__hint'.getSvgPath),
              onTapped: bloc.privacyPolicy,
              isLastItem: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 15, top: 30),
              child: Text(
                'Statistics',
                textAlign: TextAlign.left,
                style: AppTextStyles.headline4,
              ),
            ),
            SettingsItem(
              title: 'Your Activity',
              icon: SvgPicture.asset('088__pie chart'.getSvgPath),
              onTapped: bloc.yourActivity,
              isLastItem: true,
            ),
          ],
        ),
      ),
    );
  }
}
