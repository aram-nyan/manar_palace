import 'package:alux/services/LoginProvide.dart';
import 'package:flutter/material.dart';

import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:provider/provider.dart';

enum ContactOption { admin, developer }

class FeedbackCallPage extends StatelessWidget {
  static var id = 'obratnyi';
 
  FeedbackCallPage({ Key key  }) : super(key: key);

  final Map<String, dynamic> data = {};

  Widget build(BuildContext context) {
    var provide = Provider.of<LoginProvide>(context);
    return AppPage(
      single: true,
      title: 'Обратный звонок',
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onChanged: (value) => provide.callChange('name', value),
                decoration: InputDecoration(
                  labelText: 'Ваше имя'
                ),
              ),
              TextFormField(
                onChanged: (value) => provide.callChange('tel', value),
                decoration: InputDecoration(
                  labelText: 'Ваш номер телефона'
                ),
              )
            ]
            .map<Widget>((field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: field

            ))
            .followedBy([ 
              AppButton(
                white: true,
                trigger: provide.supportCallBool,
                label: 'Отправить запрос',
                onPressed: () {
                  if(provide.callMap['name'] != '' && provide.callMap['tel'] != '') provide.getCall(context);
                }
              )
            ])
            .toList() 

          )
        )
      )
    );
  }
}