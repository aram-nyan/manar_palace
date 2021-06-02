import 'package:alux/pages/CompanyInfoPage.dart';
import 'package:alux/pages/FeedbackCall.dart';
import 'package:alux/pages/HistoryOrders.dart';
import 'package:alux/pages/LocationPage.dart';
import 'package:alux/pages/LoginPage.dart';
import 'package:alux/pages/PrivacyPage.dart';
import 'package:alux/pages/ProfileEdit.dart';
import 'package:alux/pages/RegisterPage.dart';
import 'package:alux/pages/SupportPage.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/utils/Page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alux/pages/ContractPage.dart';

class _ProfilePageEntryData {
  final String text;
  final String route;
  final IconData icon;

  const _ProfilePageEntryData(this.text, this.icon, [this.route]);
}

class ProfilePage extends StatelessWidget {
  static var id = 'profilePage';
  ProfilePage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvide>(context).user;
    List<_ProfilePageEntryData> entries = [
      _ProfilePageEntryData(
          'Служба поддержки', Icons.contact_phone, SupportPage.id),
      _ProfilePageEntryData(
          'Обратный звонок', Icons.local_phone, FeedbackCallPage.id),
      if (user?.token != '' && user != null)
        _ProfilePageEntryData('Мои заказы', Icons.menu, HistoryOrder.id),
      if (user?.token != '' && user != null)
        _ProfilePageEntryData(
            'Профиль', Icons.account_circle, ProfileDataScreen.id),
      _ProfilePageEntryData(
          'Приложение Manar Palace', Icons.info, CompanyInfoPage.id),
      _ProfilePageEntryData(
          'Наши заведения по Казахстану', Icons.add_location, LocationPage.id),
      _ProfilePageEntryData(
          'Договоры оферты', Icons.insert_drive_file, ContractPage.id),
      _ProfilePageEntryData(
          'Политика конфиденциальности', Icons.description, PrivacyPage.id),
    ];
    return AppPage(
        single: true,
        title: 'Кабинет',
        content: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: entries
              .map<Widget>((entry) => ListTile(
                    leading: Icon(entry.icon,
                        color: Color.fromRGBO(0x63, 0x63, 0x63, 1.0)),
                    title: Text(entry.text),
                    onTap: () {
                      if (entry.route != null) {
                        Navigator.of(context).pushNamed(entry.route);
                      }
                    },
                  ))
              .followedBy([
            if (user.token != '')
              AppButton(
                  label: 'Выйти',
                  onPressed: () {
                    Provider.of<AuthProvide>(context, listen: false).exit();
                  }),
            if (user?.token == '' && user != null)
              AppButton(
                  label: 'Войти',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginPage.id)),
            SizedBox(
              height: 16,
            ),
            if (user?.token == '' && user != null)
              AppButton(
                  label: 'Регистрация',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RegisterPage.id)),
          ]).toList(),
        ));
  }
}
