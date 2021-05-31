
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/widgets/account/CiustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProfileDataScreen extends StatelessWidget {
  static var id = 'profileDatascreen';
  @override
  Widget build(BuildContext context) {
    var loginProvide = Provider.of<AuthProvide>(context);
    var newData = Provider.of<AuthProvide>(context).newDataForUpdate;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),onTap: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,
        title: Text('Профиль',style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Container(
            height: h-42,
            width: w,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(hintText: 'Ваше имя',onChanged: (val){
                    newData['name'] = val;
                  },),
                  SizedBox(height: 28,),
                  CustomTextField(hintText: 'Телефон',onChanged: (val){
                    newData['tel'] = val;
                  },),
                  SizedBox(height: 28,),
                  CustomTextField(hintText: 'E-mail',onChanged: (val){
                    newData['email'] = val;
                  },),
                  SizedBox(height: 28,),
                  CustomTextField(hintText: 'Пароль',obscure: true,onChanged: (val){
                    newData['password'] = val.toString();
                  },),
                  SizedBox(height: 28,),
                  CustomTextField(hintText: 'Введите пароль повторно',obscure: true,onChanged: (val){
                    newData['password_confirmation'] = val.toString();
                  },),
                  SizedBox(height: 28,),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 32),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Text(
//                          'Район доставки',
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 12,
//                              fontWeight: FontWeight.w600
//                          ),
//                        ),
//                        SizedBox(height: 8,),
////                        Container(
////                          width: w,
////                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
////                          decoration: BoxDecoration(
////                              borderRadius: BorderRadius.circular(8.0),
////                              border: Border.all()),
////                          child: DropdownButtonHideUnderline(
////                            child: DropdownButton(
////                                iconEnabledColor: Theme.of(context).primaryColor,
////                                iconSize: 32,
////                                value: newData['district'] != '' && newData['district'] != null ? newData['district'] : loginProvide.raion,
////                                items: loginProvide.adressesArray.map((e) => DropdownMenuItem<String>(
////                                  value: e,
////                                  child: Text(e),
////                                )).toList(),
////                                onChanged: (value) {
////                                  loginProvide.chengeRaionInProfile(value);
////                                }),
////                          ),
////                        ),
//                      ],
//                    ),
//                  ),
                  CustomTextField(hintText: 'Адресс доставки',onChanged: (val){
                    newData['adress'] = val;
                  },),
                  SizedBox(height: 28,),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 32),
//                    child: Row(children: [
//                      Container(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              'Номер квартиры',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontSize: 12,
//                                  fontWeight: FontWeight.w600
//                              ),
//                            ),
//                            SizedBox(height: 8,),
//                            Container(
//                              width: w/2 -40,
//                              height: 50,
//                              child: TextField(
//                                cursorColor: Colors.black,
//                                decoration: new InputDecoration(
//                                  focusedBorder: OutlineInputBorder(
//                                    borderSide: BorderSide(color: Colors.black),
//                                    borderRadius: new BorderRadius.circular(8.0),
//                                  ),
//                                  border: new OutlineInputBorder(
//                                    borderRadius: new BorderRadius.circular(8.0),
//                                    borderSide: new BorderSide(color:  Colors.black),
//                                  ),
//                                ),
//                                keyboardType: TextInputType.number,
//                                style: new TextStyle(
//                                  color: Colors.black,
//                                ),
//                                onChanged: (val){
//                                  newData['apartment'] = val.toString();
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      SizedBox(width: 16,),
//                      Container(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              'Подъезд',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontSize: 12,
//                                  fontWeight: FontWeight.w600
//                              ),
//                            ),
//                            SizedBox(height: 8,),
//                            Container(
//                              width: w/2 -40,
//                              height: 50,
//                              child: TextField(
//                                cursorColor: Colors.black,
//                                decoration: new InputDecoration(
//                                  focusedBorder: OutlineInputBorder(
//                                    borderSide: BorderSide(color: Colors.black),
//                                    borderRadius: new BorderRadius.circular(8.0),
//                                  ),
//                                  border: new OutlineInputBorder(
//                                    borderRadius: new BorderRadius.circular(8.0),
//                                    borderSide: new BorderSide(color:  Colors.black),
//                                  ),
//                                ),
//                                keyboardType: TextInputType.number,
//                                style: new TextStyle(
//                                  color: Colors.black,
//                                ),
//                                onChanged: (val){
//                                  newData['entrance'] = val.toString();
//                                },
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],),
//                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right:16,top: 32,bottom: 64),
                    child: Container(
                      width: w,
                      child: AppButton(trigger:loginProvide.isLoading, label: 'Сохранить',white:true,enable:true,onPressed: (){
                        var token = Provider.of<LoginProvide>(context,listen: false).user.token;
                        loginProvide.updateUser(context,token);
                      },),
                    ),
                  ),
                  SizedBox(height: 120,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



