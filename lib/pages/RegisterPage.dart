import 'package:alux/services/AuthProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/widgets/account/CiustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static var id = 'registerr';
  RegisterPage({ Key key  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvide>(context);
    return AppPage(
        single: true,
        title: 'Регистрация',
        content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(hintText: 'Ваше имя',onChanged: (value){
                       auth.changeRegisterMap('name', value);
                      },),
                      CustomTextField(hintText: 'Ваш номер телефона',onChanged: (value){
                        auth.changeRegisterMap('tel', value);
                      },),
                      CustomTextField(hintText: 'Ваш e-mail',
                        onChanged: (value){
                          auth.changeRegisterMap('email', value);
                        },),
                      CustomTextField(hintText: 'Пароль',
                        onChanged: (value){
                          auth.changeRegisterMap('password', value);
                        },),
                      CustomTextField(hintText: 'Повторите пароль',padding: 32.0,
                        onChanged: (value){
                          auth.changeRegisterMap('password_confirmation', value);
                        },
                      ),
                      CustomTextField(hintText: 'Адрес доставки (можно заполнить позже) или изменить в разделе в “Профиль”',padding: 38.0,
                        onChanged: (val){
                          auth.changeRegisterMap('address', val);
                        },
                      ),
                      AppButton(
                          white: true,
                          enable: auth.registreMap['password'] == auth.registreMap['password_confirmation'] &&  auth.registreMap['password'].length > 5 && auth.registreMap['email'].contains('@'),
                          label: 'Регистрация',
                          trigger: auth.isLoading,
                          onPressed: () {
                            if(auth.registreMap['password'] == auth.registreMap['password_confirmation'] &&  auth.registreMap['password'].length > 5 && auth.registreMap['email'].contains('@')){
                              auth.startLoading();
                              auth.register(context);
                            }else{
                              auth.showLoseConnection(context, 'Вниание!', 'Проверьте корректность данных', true);
                            }
                          }
                      ),
                    ]

                )
            )
        )
    );
  }
}