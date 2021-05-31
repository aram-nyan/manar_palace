import 'dart:async';
import 'dart:convert';
import 'package:alux/models/Adresses.dart';
import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/BusketItems.dart';
import 'package:alux/models/Favourite.dart';
import 'package:alux/models/FindOrders.dart';
import 'package:alux/models/HistoryOrders.dart';
import 'package:alux/models/News.dart';
import 'package:alux/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:achievement_view/achievement_view.dart';
class LoginProvide extends ChangeNotifier {
  var isLoggedIn = false;
  var networkProblem = false;
  String email = '';
  var password = '';
  User user;
  var name;
  var tel;
  var password2 = '';
  var raion;
  var adrees;
  var numberKV;
  List<int> favouriteArray = [];
  List<String> favIdJustId = [];
  var podyezd;
  StreamController<HistoryOrders> orderController;
  StreamController<FindOrders> findController;
  StreamController<News> newsController;
  List<DropdownMenuItem<String>> adresses;
  List<String> adressesArray = [];
  Favourite favouriteItem;
  BusketItems allBusket;
  HistoryOrders historyOrders;
  List<int> adressPrices = [];
  LoginProvide() {
    stateUser();
    notifyListeners();
  }
  BusketItems provideBusketItems = BusketItems(data: BusketStructure(basket: [],allPrice: 0));
  Future stateUser() async {
    user = await getUser();
   if (user.token != null && user.token != '' ) {
     provideBusketItems =  await currentBusket(user.token);
     favouriteItem = await currentFavourite(user.token);
//      sendPlayerID();
//      print(user.token);
    }
//    getAdresses();
    notifyListeners();
  }

//  Future sendPlayerID()async{
//    SharedPreferences shared = await SharedPreferences.getInstance();
//    var isSent = shared.getBool('playerid') ?? false;
//    if(!isSent){
//      var status = await OneSignal.shared.getPermissionSubscriptionState();
//      var playerID = status.subscriptionStatus.userId;
//      final respCategory = await http.post(
//          'https://manapolise.a-lux.dev/api/push/token', headers: {
//        'Accept': 'application/json',
//        'Authorization': 'Bearer ${user.token}',
//      }, body: {
//        'token': playerID,
//      }).catchError((e) => print(e));
//      if(respCategory.statusCode == 200){
//        await shared.setBool('playerid', true);
//      }
//    }
//  }
  int currentOrderPrice = 800;
  void changeOrderPrice(index){
    currentOrderPrice =  adressPrices[index];
    print(currentOrderPrice);
    notifyListeners();
  }
  Future getAdresses() async {
    try {
      final respCategory = await http.post(
          'https://manapolise.a-lux.dev/api/address').catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      if(respCategory.statusCode == 200){
        var addresses = Adresses.fromJson(jsonResp);
        if(addresses.success){
          addresses.data.forEach((element) {
            adressesArray.add(element.name);
            adressPrices.add(element.orderPrice);
          });
          raion = adressesArray[0];
          currentOrderPrice = adressPrices[0];
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  void chengeRaion(val){
    raion = val;
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
  Map<String, dynamic> deliverMap = {
    'deliver': 'Доставка',
    'comment': '',
  };
  void changeDeliverMap(key,value){
    deliverMap[key] = value;
    notDeliverMap[key] = value;
    notifyListeners();
  }
  Map<String, dynamic> notDeliverMap = {
    'deliver': 'Самовывоз',
    'comment': '',
  };
  void changeNotDeliverMap(key,value){
    notDeliverMap[key] = value;
    notifyListeners();
  }
  bool isUpdating = false;
  Future changeValue(token, newVal, id) async {
    try {
      print(newVal);
      isUpdating =true;
      notifyListeners();
      final respCategory = await http.post(
          'https://manapolise.a-lux.dev/api/basket/amount', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'basket_id': id.toString(),
        'amount': newVal.toString(),
      }).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
//      if (jsonResp['success']) {
//       await currentBusket(token);
//        isUpdating = false;
//        notifyListeners();
//      }
    } catch (e) {
      print(e);
    }
  }

  int deletingItem = -1;
void makeDelete(busketId){
  deletingItem = busketId;
  notifyListeners();
}
void changeCrement(adding,basketId,price){
  BusketItem thisItem = provideBusketItems.data.basket.where((element) => element.basketId == basketId).toList()[0];
  if(adding){
    thisItem.amount++;
    provideBusketItems.data.allPrice += price;
  }else{
    thisItem.amount--;
    provideBusketItems.data.allPrice -= price;
  }
  notifyListeners();
}
  Future<BusketItems> deleteItem(token, busketId, context) async {
    try {
      final respCategory = await http.delete(
          'https://manapolise.a-lux.dev/api/basket/delete/$busketId', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      if (respCategory.statusCode == 200 && jsonResp['success']) {
      BusketItem deletingProduct = provideBusketItems.data.basket.where((element) => element.basketId == busketId).toList()[0];
      BusketItems newTemp = provideBusketItems;
      newTemp.data.allPrice = (newTemp.data.allPrice ?? 0) - int.parse(deletingProduct.price) * deletingProduct.amount;
      newTemp.data.basket.remove(deletingProduct);
       if(newTemp.data.basket.length == 0){
         newTemp = BusketItems(success: false,data: BusketStructure(basket: [],allPrice: 0),message: 'Корзина пуста.');
       }
       notifyListeners();
        if(Navigator.canPop(context)) Navigator.pop(context);
        showLoseConnection(context, 'Успешно!', jsonResp['message'], false);
      }else{
        if(Navigator.canPop(context)) Navigator.pop(context);
        showLoseConnection(context, 'Ошибка!', jsonResp['message'], true);
      }
    } catch (e) {
      print(e);
    }
    deletingItem = -1;
    notifyListeners();
  }
  bool isClearingBusket = false;

  Future<BusketItems> deleteBusket(token, context) async {
    try {
      isClearingBusket = true;
      notifyListeners();
      final respCategory = await http.delete(
          'https://manapolise.a-lux.dev/api/basket/clear', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      if (respCategory.statusCode == 200 && jsonResp['success']) {
        showLoseConnection(context, 'Успешно!', jsonResp['message'], false);
        provideBusketItems = BusketItems(success: false,data: BusketStructure(basket: [],allPrice: 0),message: 'Корзина пуста.');
//        provideBusketItems =await currentBusket(token);
      } else {
        showLoseConnection(context, 'Ошибка!', jsonResp['message'], true);
      }
    } catch (e) {
      print(e);
    }
    isClearingBusket = false;
    notifyListeners();
  }

  int addingFavItem = -1;

  Future addFav(token, int id, context) async {
    try {
      addingFavItem = id;
      notifyListeners();
      final respCategory = await http.post(
          'https://manapolise.a-lux.dev/api/favorites/add', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'id': id.toString()
      }).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      if (respCategory.statusCode == 200 && jsonResp['success']) {
        FavouriteItem newItem = FavouriteItem.fromJson(jsonResp['data']);
        showLoseConnection(context, 'Успешно!', jsonResp['message'], false);
        currentFavourite(token);
      } else {
        showLoseConnection(context, 'Ошибка!', jsonResp['message'], true);
        currentFavourite(token);
      }
    } catch (e) {
      print(e);
    }
    addingFavItem = -1;
    notifyListeners();
  }

  Future<BusketItems> deleteFav(token, int id,int justId, context) async {
    try {
      addingFavItem = justId;
      notifyListeners();
      final respCategory = await http.delete(
        'https://manapolise.a-lux.dev/api/favorites/delete/$id', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      if (respCategory.statusCode == 200 && jsonResp['success']) {
        showLoseConnection(context, 'Успешно!', jsonResp['message'], false);
        favIdJustId.remove(
            justId.toString() + ':' + id.toString());
        favouriteArray.remove(justId);
        print(favouriteArray);
        notifyListeners();
      } else {
        showLoseConnection(context, 'Ошибка!', jsonResp['message'], true);
        currentFavourite(token);
      }
    } catch (e) {
      print(e);
    }
    addingFavItem = -1;
    notifyListeners();
  }

  var allTabs = [];


  int isAddingItem = -1;
  BusketItems addLocal(ProductModel product,price,count){

    allBusket.data.allPrice = allBusket.data.allPrice + price;
    allBusket.data.basket.add(BusketItem());
  }
  Future addToBusket(int id,token,context,int amount)async{
    try{
        isAddingItem = id;
        notifyListeners();
        var idString = id.toString();
        final respCategory = await http.post('https://manapolise.a-lux.dev/api/basket/add',
            body: {
              'id': idString,
              'amount': amount.toString(),
            },
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }
        );
        Map<dynamic, dynamic> jsonResp = json.decode(respCategory.body);
      if(jsonResp['success']){
          isAddingItem = -1;
          BusketItem neeProduct;
          jsonResp['data'].forEach((element,vaue) {
            neeProduct = BusketItem.fromJson(vaue);
            neeProduct.amount = amount;
            neeProduct.basketId = int.parse(element);
          });
          if(provideBusketItems.success == false){
            provideBusketItems = BusketItems(success: false,data: BusketStructure(basket: [],allPrice: 0),message: 'Корзина пуста.');
          }
          provideBusketItems.data.allPrice = (provideBusketItems.data.allPrice ?? 0) +int.parse(neeProduct.price) * amount;
          provideBusketItems.data.basket.add(neeProduct);
          provideBusketItems.success = true;
          showLoseConnection(context, 'Успешно!',  jsonResp['message'], false);
        }else{
          showLoseConnection(context, 'Ошибка!',  jsonResp['message'], true);
        }
        isAddingItem = -1;
        notifyListeners();
    }catch(e){
      showLoseConnection(context, 'Ошибка!', 'Проверьте соединение с сетью', true);
      print(e);
      isAddingItem = -1;
    }
    notifyListeners();
  }

  Future<BusketItems> currentBusket(token) async {
    try {
        final respCategory = await http.get(
            'https://manapolise.a-lux.dev/api/basket/current', headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).catchError((e) => print(e));
        var busketItems;
        if (respCategory.statusCode == 200) {
          var jsonResp = json.decode(respCategory.body);
          if(!jsonResp['success']){
            provideBusketItems = BusketItems(success: false,data: BusketStructure(basket: [],allPrice: 0),message: 'Корзина пуста.');
            print(provideBusketItems.data.allPrice);
          }else{
            busketItems = BusketItems.fromJson(jsonResp);
            provideBusketItems = busketItems;
          }
          notifyListeners();
          return busketItems;
        } else if (respCategory.statusCode == 404) {
          var jsonResp = json.decode(respCategory.body);
          busketItems = BusketItems.fromJson(jsonResp);
          provideBusketItems = busketItems;
          notifyListeners();
          return busketItems;
        }
      return provideBusketItems;
    } catch (e) {
      print(e);
    }
  }

  Future currentHitory(token) async {
    try {
      final respCategory = await http.get(
          'https://manapolise.a-lux.dev/api/orders/history/products', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }).catchError((e) => print(e));
      HistoryOrders HistoryName;
      if (respCategory.statusCode == 200) {
        var jsonResp = json.decode(respCategory.body);
        HistoryName = HistoryOrders.fromJson(jsonResp);
        historyOrders = HistoryName;
        print('i did it already');
      } else if (respCategory.statusCode == 404) {
        var jsonResp = json.decode(respCategory.body);
        HistoryName = HistoryOrders.fromJson(jsonResp);
        orderController.add(HistoryName);
        historyOrders = HistoryName;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  bool ordering = false;
  Future<Favourite> currentFavourite(token) async {
    try {
        final respCategory = await http.get(
            'https://manapolise.a-lux.dev/api/favorites/current', headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).catchError((e) => print(e));
        if (respCategory.statusCode == 200) {
          print('i downloaded po idee');
          var jsonResp = json.decode(respCategory.body);
          favouriteItem = Favourite.fromJson(jsonResp);
          favouriteItem.data.forEach((element) {
            favouriteArray.add(element.id);
            favIdJustId.add(
                element.id.toString() + ':' + element.favoritId.toString());
          });
          notifyListeners();
          return favouriteItem;
        } else if (respCategory.statusCode == 404) {
          var jsonResp = json.decode(respCategory.body);
          if(!jsonResp['success']){
            print('sign');
            favouriteItem = Favourite.fromJson(jsonResp);
          }
          return favouriteItem;
        }
        notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  bool isOrdering = false;
  Future order(token, context,isDeliver,int persons) async {
    try {
      isOrdering = true;
      notifyListeners();
      deliverMap['persons'] = persons.toString() ?? '1';
      notDeliverMap['persons'] = persons.toString() ?? '1';
      final respCategory = await http.post(
          'https://manapolise.a-lux.dev/api/orders/new', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },body: isDeliver ? deliverMap : notDeliverMap).catchError((e) => print(e));
      if (respCategory.statusCode == 200) {
        var jsonResp = json.decode(respCategory.body);
        provideBusketItems = BusketItems(success: false,data: BusketStructure(basket: [],allPrice: 0),message: 'Корзина пуста.');
        if(Navigator.canPop(context)) Navigator.pop(context);
        showLoseConnection(context, 'Успешно!', jsonResp['message'], false);
      } else if (respCategory.statusCode == 404) {
        var jsonResp = json.decode(respCategory.body);
        if(Navigator.canPop(context)) Navigator.pop(context);
        showLoseConnection(context, 'Ошибка!', jsonResp['message'], true);
      }
    } catch (e) {
      print(e);
    }
    isOrdering = false;
    notifyListeners();
  }

  Future findNews() async {
    try {
      final respCategory = await http.get(
        'https://manapolise.a-lux.dev/api/news/catalog',).catchError((e) => print(e));
      var jsonResp = json.decode(respCategory.body);
      News news = News.fromJson(jsonResp);
      if (respCategory.statusCode == 200) {
        newsController.add(news);
      } else if (respCategory.statusCode == 404) {
        newsController.add(news);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  var forgotLogin = '';
  var forgotLoading = false;
  Map<String, dynamic> supportMap = {
    'whom':'Администратор заведения',
    'login':'',
  };
  void changeWhom(key,val){
   
    supportMap[key] = val;
    notifyListeners();
  }
  var supportBool = false;
  Future<dynamic> getSupport(context) async {
    try {
      supportBool = true;
      notifyListeners();
      final response = await http.post(
          'https://manapolise.a-lux.dev/api/message', body: supportMap);
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        Navigator.pop(context);
        showLoseConnection(context, 'Успешно', 'Заявка приянта', false);
      } else {
        showLoseConnection(context, 'Ошибка', 'Попробуйте позже', true);
      }
    } catch (e) {
      print(e);
    }
    supportBool = false;
    notifyListeners();
  }

  Map<String, dynamic> callMap = {
    'name':'',
    'tel':'',
  };

  void callChange(key,val){
    callMap[key] = val;
    notifyListeners();
  }
  var supportCallBool = false;
  Future<dynamic> getCall(context) async {
    try {
      supportCallBool = true;
      notifyListeners();
      final response = await http.post(
          'https://manapolise.a-lux.dev/api/message', body: callMap);
      var jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        Navigator.pop(context);
        showLoseConnection(context, 'Успешно', 'Заявка приянта', false);
      } else {
        showLoseConnection(context, 'Ошибка', 'Попробуйте позже', true);
      }
    } catch (e) {
      print(e);
    }
    supportCallBool = false;
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

}


