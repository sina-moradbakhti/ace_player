import 'package:ace_player/appRepo.dart';
import 'package:get/get.dart';

class BlocBase extends GetxController {
  final repo = AppRepo();

  void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
  }
}
