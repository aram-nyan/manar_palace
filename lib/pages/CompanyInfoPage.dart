import 'package:flutter/material.dart';

import 'package:alux/utils/Page.dart';

enum ContactOption { admin, developer }

class CompanyInfoPage extends StatelessWidget {
  static var id = 'info';
 
  CompanyInfoPage({ Key key  }) : super(key: key);

  final Map<String, dynamic> data = {};

  Widget build(BuildContext context) {
    return AppPage(
      single: true,
      title: 'О нас',
      content: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 105,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 00),
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),
          
          Padding(padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('''Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.

          The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
            ''', 
            style: TextStyle(
              color: Color.fromRGBO(0x16, 0x16, 0x16, 1.0),
              fontSize: 14
            ))
          ),
          
          Image.asset('assets/company-map.png'),
        ]
      )
    );
  }
}