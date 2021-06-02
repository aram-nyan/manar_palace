import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
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
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'Ваше имя'),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        controller: _controller,
                        decoration:
                            InputDecoration(labelText: 'Ваш номер телефона'),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'Ваш e-mail'),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(labelText: 'Пароль'),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextFormField(
                        controller: _controller,
                        maxLines: 2,
                        decoration: InputDecoration(
                            labelText:
                                'Адрес доставки (можно заполнить позже) или изменить в разделе в “Профиль”'),
                      )),
                  AppButton(label: 'Регистрация', onPressed: () {}),
                  TextButton(
                    child: Text('Забыли пароль?'),
                    onPressed: () {},
                  )
                ]))));
  }
}
