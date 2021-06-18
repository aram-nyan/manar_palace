import 'package:alux/services/AuthProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/widgets/account/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatefulWidget {
  static var id = 'forgotPage';
  ForgotPage({Key key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvide>(context);
    var canTap = auth.forgotLogin.length > 4;
    return AppPage(
        single: true,
        title: 'Восстановление пароля',
        content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Text(
                    'Введите e-mail или номер телефона, указанный при регистарции',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'E-mail или номер телефона',
                    padding: 16.0,
                    onChanged: (value) {
                      auth.changeForgotLogin(value);
                    },
                  ),
                  AppButton(
                      trigger: auth.forgotLoading,
                      white: true,
                      label: 'Отправить письмо',
                      onPressed: () {
                        if (canTap) {
                          auth.sendEmail(context);
                        }
                      }),
                ]))));
  }
}
