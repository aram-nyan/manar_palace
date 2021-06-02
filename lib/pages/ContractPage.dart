import 'package:alux/utils/Page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContractPage extends StatelessWidget {
  static var id = 'ContractPage';
  const ContractPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
        single: true,
        title: 'Договоры оферты',
        content: WebView(
          initialUrl: 'https://manapolise.a-lux.dev/api/page/oferta/oferta',
        ));
  }
}
