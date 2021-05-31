import 'package:alux/pages/CompanyInfoPage.dart';
import 'package:alux/pages/FeedbackCall.dart';
import 'package:alux/pages/SupportPage.dart';
import 'package:flutter/material.dart';

import 'package:alux/pages/LoginPage.dart';
import 'package:alux/pages/ProfilePage.dart';

import 'AppViewController.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => AppViewController(),
  '/login': (context) => LoginPage(),
  '/profile-page': (context) => ProfilePage(),
  '/support': (context) => SupportPage(),
  '/feedback-call': (context) => FeedbackCallPage(),
  '/company-info': (context) => CompanyInfoPage()
};