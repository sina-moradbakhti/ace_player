import 'package:ace_player/blocs/home.bloc.dart';
import 'package:ace_player/components/miniPlayer.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:ace_player/page/planet.page.dart';
import 'package:ace_player/page/playlist.page.dart';
import 'package:ace_player/page/musics.page.dart';
import 'package:ace_player/page/settings.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ace_player/utils/ext.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final bloc = Get.put(HomeBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_content, _miniPlayer]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Musics',
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset('140__music'.getSvgPath),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: SvgPicture.asset(
                    '140__music'.getSvgPath,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                  label: 'Playlists',
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('031__list'.getSvgPath),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('031__list'.getSvgPath,
                        color: Get.theme.primaryColor),
                  )),
              BottomNavigationBarItem(
                  label: 'Planet',
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('072__planet'.getSvgPath),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('072__planet'.getSvgPath,
                        color: Get.theme.primaryColor),
                  )),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('082__setting_cog'.getSvgPath),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SvgPicture.asset('082__setting_cog'.getSvgPath,
                        color: Get.theme.primaryColor),
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

  Widget get _content => PageView(
        controller: bloc.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MusicsPage(),
          PlaylistPage(),
          const PlanetPage(),
          SettingsPage()
        ],
      );

  Widget get _miniPlayer => Align(
        alignment: Alignment.bottomCenter,
        child: StreamBuilder(
          stream: bloc.repo.player.player.playerState,
          builder: (context, snapshot) => GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dy > 0) {
                bloc.repo.player.stop();
              }
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(animation),
                  child: child),
              child: bloc.repo.player.currentMusic == null
                  ? Container(height: 80)
                  : MiniPlayerWidget(),
            ),
          ),
        ),
      );
}
