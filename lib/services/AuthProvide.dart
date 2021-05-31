import 'dart:async';
import 'dart:convert';
import 'package:alux/models/Adresses.dart';
import 'package:alux/models/BusketItems.dart';
import 'package:alux/models/Favourite.dart';
import 'package:alux/models/FindOrders.dart';
import 'package:alux/models/HistoryOrders.dart';
import 'package:alux/models/News.dart';
import 'package:alux/models/Order.dart';
import 'package:alux/models/user.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:achievement_view/achievement_view.dart';
class AuthProvide extends ChangeNotifier {
  User user;
  AuthProvide() {
    stateUser();
    notifyListeners();
  }
  BusketItems provideBusketItems = BusketItems(data: BusketStructure(basket: []));
  Future stateUser() async {
    user = await getUser();
    notifyListeners();
  }
  Future<User> getUser() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var userAr = shared.getString('user') ?? '';
    UserObj userObj;
    if (userAr != '' && userAr != null) {
      var newJson = json.decode(userAr);
      userObj = UserObj.fromJson(newJson);
      user = userObj.data;
    }else{
      user = User(token: '');
      return user;
    }
    notifyListeners();
    return user;
  }
  Future exit() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('user', '');
    saveUser('');
    stateUser();
    notifyListeners();
  }
  bool isLoading = false;
  Map<String, dynamic> loginMap = {};
  Map<String, dynamic> registreMap = {
    'email': '',
    'password': '',
    'password_confirmation': '',
    'tel': '',
    'name': '',
    'address': '',
  };
  void changeRegisterMap(key,value){
    registreMap[key] = value;
    notifyListeners();
  }
  var loginOrTel = '';
  var passwordLog = '';
  bool isChecked = false;
  Future<dynamic> checkExist(context) async {
    try {
      final response = await http.post('https://manapolise.a-lux.dev/api/user/check', body: {
        'login':loginOrTel,
      });
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        isChecked = true;
      } else {
        showLoseConnection(context, 'Ошибка',jsonData['message'], true);
      }
    } catch (e) {
      showLoseConnection(context, 'Ошибка',e, true);
      print(e);
    }
    notifyListeners();
  }

  Future<dynamic> login(context) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.post('https://manapolise.a-lux.dev/api/login', body:{
        'login':loginOrTel,
        'password':passwordLog,
      });
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        await saveUser(response.body);
        isChecked = false;
        loginOrTel = '';
        passwordLog = '';
        Navigator.pop(context);
        Provider.of<LoginProvide>(context,listen: false).currentBusket(user.token);
      } else {
        showLoseConnection(context, 'Ошибка', jsonData['message'], true);
      }
    } catch (e) {
      showLoseConnection(context, 'Ошибка','Проверьте соединение с интернетом', true);
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
  Future saveUser( jsonData) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString('user', jsonData.toString());
    user = await getUser();
    notifyListeners();
  }
  Future<dynamic> register(context) async {
    try {
      print(registreMap);
      isLoading = true;
      final response = await http.post('https://manapolise.a-lux.dev/api/register', body: registreMap);
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['success'] == true) {
        saveUser(response.body);
        Navigator.of(context).pop(context);
      } else {
        showLoseConnection(context, 'Ошибка', jsonData['message'], true);
      }
    } catch (e) {
      print(e);
      showLoseConnection(context, 'Ошибка','Проверьте соединение с интернетом', true);
    }
    isLoading = false;
    notifyListeners();
  }
  void showLoseConnection(BuildContext context, mainText, subText, error) {
    AchievementView(context,
        title: mainText,
        subTitle: subText,
        //onTab: _onTabAchievement,
        icon: Icon(
          error ? Icons.error : Icons.check,
          color: Theme
              .of(context)
              .primaryColor,
        ),
        color: Colors.white,
        textStyleTitle: TextStyle(color: Theme
            .of(context)
            .primaryColor),
        textStyleSubTitle: TextStyle(fontSize: 12, color: Theme
            .of(context)
            .primaryColor),
        duration: Duration(seconds: 1),
        isCircle: true,
        listener: (status) {})
      ..show();
  }

  var forgotLogin = '';
  var forgotLoading = false;
  void changeForgotLogin(value){
    forgotLogin = value;
    notifyListeners();
  }
  Future<dynamic> sendEmail(context) async {
    try {
      forgotLoading = true;
      notifyListeners();
      final response = await http.post(
        'https://manapolise.a-lux.dev/api/user/password/code', body: {
        'email':forgotLogin,
      },);
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        showLoseConnection(context, 'Успешно', jsonData['message'], false);
        Navigator.pop(context);
      } else {
        showLoseConnection(context, 'Ошибка', jsonData['message'], true);
      }
    } catch (e) {
      print(e);
    }
    forgotLoading = false;
    notifyListeners();
  }
  Map<String, dynamic> newPassword = {};
  Future<dynamic> resetPassword(context) async {
    try {
      forgotLoading = true;
      notifyListeners();
      final response = await http.post(
          'https://manapolise.a-lux.dev/api/user/password/reset', body: newPassword);
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        showLoseConnection(context, 'Успешно', 'Пароль изменен', false);
      } else {
        showLoseConnection(context, 'Ошибка', jsonData['message'], true);
      }
    } catch (e) {
      print(e);
    }
    forgotLoading = false;
    notifyListeners();
  }
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }
  Map<String, dynamic> newDataForUpdate = {};
  void chengeRaionInProfile(val){
    newDataForUpdate['district'] = val;
    notifyListeners();
  }
  Future<dynamic> updateUser(context, token) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.post(
        'https://manapolise.a-lux.dev/api/user/edit', body: newDataForUpdate, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        var initialMap = user.toMyJson();
        initialMap.forEach((key, value) {
          if(newDataForUpdate[key] != null){
            initialMap[key] = newDataForUpdate[key];
          }
        });
        String newSTR = json.encode(initialMap);
        var jsonResp = json.decode(newSTR);
        User newUser =  User.fromJson(jsonResp);
        SharedPreferences shared = await SharedPreferences.getInstance();
        var prevString = shared.getString('user');
        var prevJson = json.decode(prevString);
        UserObj newUserObj = UserObj.fromJson(prevJson);
        newUserObj.data = newUser;
        var saveMap = newUserObj.toJson();
        var saveString = json.encode(saveMap);
        saveUser(saveString);
        showLoseConnection(context, 'Успешно', jsonData['message'], false);
      } else {
        showLoseConnection(context, 'Ошибка', jsonData['message'], true);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

}


