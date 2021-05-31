import 'package:alux/utils/SingleAppBar.dart';
import 'package:flutter/material.dart';

import '../AppBar.dart';

class AppPage extends StatelessWidget {
  final Widget content; 

  final String title; 
  final bool single;

  AppPage({ Key key, this.content, this.single = false, this.title }) : super(key: key);


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: single
        ? SingleAppBar(title: title)
        : AluxAppBar(),
      body: content
    );
  }
}