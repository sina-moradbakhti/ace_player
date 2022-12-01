import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/components/navigation.dart';
import 'package:ace_player/page/favs.view.dart';
import 'package:ace_player/page/musics.view.dart';
import 'package:ace_player/page/settings.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final bloc = Get.put(HomeBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: bloc.import, icon: Icon(Icons.add_rounded))
        ],
      ),
      body: PageView(
        controller: bloc.pageController,
        children: [MusicsView(), FavsView(), SettingsView()],
      ),
      bottomNavigationBar: MainBottomNavigation(),
    );
  }
}
