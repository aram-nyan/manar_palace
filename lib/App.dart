import 'package:flutter/material.dart';

import 'package:alux/AppTheme.dart';
import 'package:alux/routes.dart';

class App extends StatelessWidget {
 
  App({ Key key  }) : super(key: key);


  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      theme: AppTheme.light,
    );
  }
}