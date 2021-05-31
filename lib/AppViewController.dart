import 'package:flutter/material.dart';

import 'package:alux/AppBottomBar.dart';

import 'package:alux/views/CartView.dart';
import 'package:alux/views/FavoriteView.dart';
import 'package:alux/views/MainView.dart';
import 'package:alux/views/NewsView.dart';
import 'package:alux/views/ShopView.dart';
class AppViewController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppViewControllerState();
  }
}

class _AppViewControllerState extends State<AppViewController> {
  final pages = [
    MainView(key: PageStorageKey('Main')),
    ShopView(key: PageStorageKey('Shop')),
    NewsView(key: PageStorageKey('News')),
    FavoriteView(key: PageStorageKey('Favorite')),
    CartView(key: PageStorageKey('MainView'))
  ];

  int _viewIndex;

  final bucket = PageStorageBucket();

  @override
  void initState() {
    _viewIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: pages[_viewIndex],
        ),
        bottomNavigationBar: AppBottomBar(
          currentIndex: _viewIndex,
          onTap: _changeView
        ),
      )
    );
  }

  void _changeView(int index) {
    setState(() {
      _viewIndex = index;
    });
  }

}