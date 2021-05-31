import 'package:alux/services/LoginProvide.dart';
import 'package:alux/utils/PopupFormField.dart';
import 'package:flutter/material.dart';

import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:provider/provider.dart';

enum ContactOption { admin, developer }

class SupportPage extends StatelessWidget {
  static var id = 'contactpage';
 
  SupportPage({ Key key  }) : super(key: key);

  final Map<String, dynamic> data = {};

  Widget build(BuildContext context) {
    var provide = Provider.of<LoginProvide>(context);
    return AppPage(
      single: true,
      title: 'Служба поддержки',
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              PopupFormField<ContactOption>(
                onChanged: (value) => provide.supportMap['whom'] = value,
                initialValue: ContactOption.admin,
                label: 'С кем связаться',
                entries: [
                  PopupFieldEntry(ContactOption.admin, 'Администрация заведения'),
                  PopupFieldEntry(ContactOption.developer, 'Разработчики приложения')
                ],
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: TextFormField(
                  onChanged: (value) => provide.supportMap['login'] = value,
                  decoration: InputDecoration(
                    labelText: 'E-mail или номер телефона'
                  ),
                )
              ),
              
              AppButton(
                label: 'Отправить',
                  white: true,
                  trigger: provide.supportBool,
                  onPressed: () {
                    if(provide.supportMap['login'] != '' && provide.supportMap['whom'] != '') provide.getSupport(context);
                  }
              )
            ]

          )
        )
      )
    );
  }
}