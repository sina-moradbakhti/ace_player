import 'package:ace_player/blocs/base.bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBloc extends BlocBase {
  var selectedNavItem = 0.obs;
  final pageController = PageController(initialPage: -1);

  void changeTab(int navItem) {
    selectedNavItem.value = navItem;
    pageController.animateToPage(navItem,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  }
}
