import 'package:ace_player/blocs/settings.bloc.dart';
import 'package:ace_player/components/settings_item.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final bloc = Get.put(SettingsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTextStyles.headline2,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 15, top: 30),
            child: Text(
              'Appearance',
              textAlign: TextAlign.left,
              style: AppTextStyles.headline3,
            ),
          ),
          Obx(() => SettingsItem(
                title: 'Enable dark mod',
                hasSwitch: true,
                switchOn: bloc.darkMod.value,
                icon: Image.asset('icon_moon'.getPngPath),
                onTapped: bloc.toggleTheme,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 15, top: 30),
            child: Text(
              'Generals',
              textAlign: TextAlign.left,
              style: AppTextStyles.headline3,
            ),
          ),
          SettingsItem(
            title: 'Report bug',
            icon: Image.asset('icon_bug'.getPngPath),
            onTapped: bloc.reportBug,
          ),
          SettingsItem(
            title: 'Rate & review our app',
            icon: Image.asset('icon_rate_review'.getPngPath),
            onTapped: bloc.rateReview,
          ),
          SettingsItem(
            title: 'Buy me a coffe',
            icon: Image.asset('icon_buy_me_coffe'.getPngPath),
            onTapped: bloc.buyMeCoffe,
          ),
          SettingsItem(
            title: 'Terms & condition',
            icon: Image.asset('icon_terms_condition'.getPngPath),
            onTapped: bloc.termsCondition,
          ),
          SettingsItem(
            title: 'Privacy Policy',
            icon: Image.asset('icon_privacy_policy'.getPngPath),
            onTapped: bloc.privacyPolicy,
            isLastItem: true,
          ),
        ],
      ),
    );
  }
}
