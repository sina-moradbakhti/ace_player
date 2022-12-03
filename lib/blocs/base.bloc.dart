import 'package:ace_player/appRepo.dart';
import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlocBase extends GetxController {
  final repo = AppRepo();

  void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }

  void showError(String message) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        message,
        style: AppTextStyles.normal.copyWith(color: Colors.white),
      ),
      backgroundColor: AppColors.mainRed,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.TOP,
    ));
  }
}
