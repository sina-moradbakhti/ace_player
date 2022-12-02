import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/page/playlist.page.dart';
import 'package:ace_player/page/musics.page.dart';
import 'package:ace_player/page/settings.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final bloc = Get.put(HomeBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: bloc.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [MusicsPage(), PlaylistPage(), SettingsPage()],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: 'Musics',
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2.5),
                  child: Icon(Ionicons.headset_outline),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 2.5),
                  child: Icon(Ionicons.headset_outline),
                ),
              ),
              BottomNavigationBarItem(
                  label: 'Playlists',
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 2.5),
                    child: Icon(Ionicons.musical_notes_outline),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 2.5),
                    child: Icon(Ionicons.musical_notes_outline),
                  )),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 2.5),
                    child: Icon(Ionicons.settings_outline),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 2.5),
                    child: Icon(Ionicons.settings_outline),
                  ))
            ],
            elevation: 0,
            selectedLabelStyle:
                AppTextStyles.caption3.copyWith(fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                AppTextStyles.caption3.copyWith(fontWeight: FontWeight.w700),
            currentIndex: bloc.selectedNavItem.value,
            onTap: (navItem) => bloc.changeTab(navItem),
          )),
    );
  }
}
