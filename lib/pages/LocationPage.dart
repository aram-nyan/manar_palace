import 'package:alux/utils/Page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationPage extends StatelessWidget {
  static var id = 'LocationPage';
  const LocationPage({Key key}) : super(key: key);
  // var json = Map<String,dynamic>();

  @override
  Widget build(BuildContext context) {
    // String name = json['data']['name'];
    return AppPage(
      single: true,
      title: 'Наши заведения по Казахстану',
      // content: WebView(
      //     initialUrl: 'https://manapolise.a-lux.dev/api/page/oferta/aboutus'),
    );
  }
}
