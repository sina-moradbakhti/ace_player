import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:get/get.dart';

class SettingsBloc extends BlocBase {
  final InAppReview _inAppReview = InAppReview.instance;

  var darkMod = false.obs;

  void help() {}

  void reportBug() {
    final mailtoLink = Mailto(
      to: ['reportbug@asbrothers.ca'],
      subject: 'Report Bug (AcePlayer)',
      body: '',
    );
    launchUrlString('$mailtoLink');
  }

  void toggleTheme() async {
    darkMod.value = !darkMod.value;
    repo.darkMod = darkMod.value;
    await repo.storage.write(AppConfigs.storageKeyDarkMod, darkMod.value);
    Get.changeThemeMode(repo.darkMod ? ThemeMode.dark : ThemeMode.light);
  }

  void rateReview() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    }
  }

  void buyMeCoffe() => Uri.parse(AppConfigs.buyMeCoffeLink).launchUrl();
  void termsCondition() => Uri.parse(AppConfigs.termsLink).launchUrl();
  void privacyPolicy() => Uri.parse(AppConfigs.privacyLink).launchUrl();

  void yourActivity() {}

  @override
  void onInit() {
    darkMod.value = repo.darkMod;
    super.onInit();
  }
}
