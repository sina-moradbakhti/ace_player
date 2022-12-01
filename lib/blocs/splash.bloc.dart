import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/routes.dart';
import 'package:get/get.dart';

class SplashBloc extends BlocBase {
  final int SPLASH_TIME = 3;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() async {
    await Future.delayed(Duration(seconds: SPLASH_TIME));
    Get.offAllNamed(AppRoutes.main);
  }
}
