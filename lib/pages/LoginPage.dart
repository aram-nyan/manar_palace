import 'package:alux/pages/ForgotPass.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/widgets/account/CiustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static var id = 'loginpage';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvide>(context);
    return AppPage(
        single: true,
        title: 'Вход',
        content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Text(
                    'Введите e-mail или номер телефона, чтобы войти или зарегистрироваться',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'E-mail или номер телефона',
                    padding: 16.0,
                    onChanged: (value) {
                      auth.loginOrTel = value;
                    },
                  ),
                  if (auth.isChecked) ...[
                    SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      hintText: 'Пароль',
                      padding: 16.0,
                      onChanged: (value) {
                        auth.passwordLog = value;
                      },
                    ),
                  ],
                  AppButton(
                      trigger: auth.isLoading,
                      white: true,
                      label: 'Войти',
                      onPressed: () {
                        if (auth.isChecked) {
                          Provider.of<AuthProvide>(context, listen: false)
                              .login(context);
                        } else {
                          auth.checkExist(context);
                        }
                      }),
                  TextButton(
                    child: Text('Забыли пароль?'),
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPage.id);
                    },
                  )
                ]))));
  }
}
