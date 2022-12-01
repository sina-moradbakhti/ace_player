import 'package:ace_player/configs.dart';
import 'package:ace_player/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConfigs.appTitle,
      theme: AppConfigs.appThemeData,
      initialRoute: AppRoutes.splash,
      getPages: AppConfigs.pages,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: child,
      ),
    );
  }
}
