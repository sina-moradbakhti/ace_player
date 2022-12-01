import 'package:ace_player/blocs/navigation.bloc.dart';
import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavigation extends StatelessWidget {
  MainBottomNavigation({super.key});

  final bloc = Get.put(NavigationBloc());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Musics',
              icon: Icon(Icons.queue_music_sharp),
              activeIcon: Icon(Icons.music_note_rounded),
            ),
            BottomNavigationBarItem(
                label: 'Fav',
                icon: Icon(Icons.favorite_border_rounded),
                activeIcon: Icon(Icons.favorite_rounded)),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings_suggest_rounded))
          ],
          elevation: 0,
          selectedLabelStyle:
              AppTextStyles.caption3.copyWith(fontWeight: FontWeight.w700),
          unselectedLabelStyle:
              AppTextStyles.caption3.copyWith(fontWeight: FontWeight.w700),
          currentIndex: bloc.selectedNavItem.value,
          onTap: (navItem) => bloc.selectedNavItem.value = navItem,
        ));
  }
}
