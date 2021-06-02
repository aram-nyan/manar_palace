import 'dart:io';

import 'package:alux/utils/Page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatefulWidget {
  static var id = 'PrivacyPage';
  const PrivacyPage({Key key}) : super(key: key);

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    void initState() {
      super.initState();
      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
        single: true,
        title: 'Политика конфиденциальности',
        content: WebView(
          initialUrl: 'https://manapolise.a-lux.dev/api/page/oferta/politics',
        ));
  }
}
