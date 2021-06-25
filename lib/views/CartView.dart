import 'dart:async';
import 'package:alux/pages/LoginPage.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:alux/models/BusketItems.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/utils/AppButton.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:alux/widgets/account/CustomTextField.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var samvyvoz = false;
  var personsCount = 1;
  var overall = 0;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvide>(context).user;
    var provide = Provider.of<LoginProvide>(context);
    var provideBusket = Provider.of<LoginProvide>(context).provideBusketItems;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    final persons = Container(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
              child: Image.asset('assets/logo.png', fit: BoxFit.scaleDown),
              flex: 1),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Количество персон'),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (personsCount > 1) {
                                      setState(() {
                                        personsCount--;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.indeterminate_check_box,
                                      color: Theme.of(context).primaryColor,
                                      size: 30)),
                              Text(personsCount.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      personsCount++;
                                    });
                                  },
                                  icon: Icon(Icons.add_box,
                                      color: Theme.of(context).primaryColor,
                                      size: 30))
                            ])
                      ])),
              flex: 2)
        ]));
    Column allWidgets = Column(
      children: [
        Container(
          width: w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Самовывоз',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Switch(
                value: samvyvoz,
                onChanged: (v) {
                  setState(() {
                    samvyvoz = v;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        Divider(),
        CustomTextField(
          hintText: 'Коментарии к заказу',
          onChanged: (val) {
            provide.changeDeliverMap('comment', val);
          },
        ),
        Divider(),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Корзина',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            if (user.token != '' && user != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    provide.deleteBusket(user.token, context);
                  },
                  child: Provider.of<LoginProvide>(context, listen: false)
                              .isClearingBusket ==
                          false
                      ? Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        )
                      : LoadingCircle(),
                ),
              )
          ],
        ),
        body: user == null || user.token == ''
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(50),
                        child: Icon(Icons.cancel,
                            color: Theme.of(context).primaryColor, size: 250),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Для доступа в раздел необходимо',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0x16, 0x16, 0x16, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16))),
                      RaisedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(LoginPage.id),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: Text('Войти',
                            style: TextStyle(
                                color: Theme.of((context))
                                    .textTheme
                                    .bodyText1
                                    .color,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      )
                    ]))
            : user.token != '' && user != null
                ? provideBusket != null && (provideBusket.success ?? false)
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return i == 0
                                    ? persons
                                    : i ==
                                            (provideBusket.data.basket.length +
                                                    2) -
                                                1
                                        ? allWidgets
                                        : ProductItem(i: i - 1);
                              },
                              itemCount: provideBusket.data.basket.length + 2,
                              padding: EdgeInsets.all(16),
                            ),
                          ),
                          Container(
                              width: w,
                              height: 64,
                              padding: EdgeInsets.all(8),
                              child: RaisedButton(
                                onPressed: () {
                                  showPlatformDialog(
                                    context: context,
                                    builder: (_) => BasicDialogAlert(
                                      title: Text(
                                        provide.isOrdering
                                            ? 'Подождите'
                                            : "Мы свяжемся с вами после подверждения заказа ",
                                      ),
                                      actions: <Widget>[
                                        BasicDialogAction(
                                          title: Text(
                                            "Отмена",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        BasicDialogAction(
                                          title: Text(
                                            "Подтвердить заказ",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          onPressed: () {
                                            provide.order(user.token, context,
                                                samvyvoz, personsCount);
                                            // showDialog(
                                            //     context: context,
                                            //     builder:
                                            //         (BuildContext context) =>
                                            //             AlertDialog(
                                            //               title: Text(
                                            //                   'Ваш заказ принят'),
                                            //               content: Text(
                                            //                   'Мы свяжемся с вами '),
                                            //               actions: [
                                            //                 IconButton(
                                            //                     onPressed:
                                            //                         () {},
                                            //                     icon: Icon(Icons
                                            //                         .close_sharp))
                                            //               ],
                                            //             ));
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Оформить заказ',
                                        style: TextStyle(
                                            color: Theme.of((context))
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    Text(
                                        (provideBusket.data.allPrice)
                                                .toString() +
                                            ' ₸',
                                        style: TextStyle(
                                            color: Theme.of((context))
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                  ],
                                ),
                              ))
                        ],
                      )
                    : provideBusket != null &&
                            (provideBusket.success ?? false) == false
                        ? Center(
                            child: Text(provideBusket.message ?? ''),
                          )
                        : LoadingCircle()
                : buildFromState(context));
  }

  Widget buildFromState(
    BuildContext context,
  ) {
    return Center(child: Text('Корзина пуста'));
  }
}

//List<ProductItem> getAllProducts(BusketItems all){
//  List<ProductItem> allProducts = [];
//  all.data.basket.forEach((element) {
//    allProducts.add(ProductItem(e: element,));
//  });
//  return allProducts;
//}
class ProductItem extends StatefulWidget {
  final i;
  ProductItem({this.i});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int amount = 1;
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('having');
    setState(() {
      timer = Timer(Duration(), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDeleting = Provider.of<LoginProvide>(context).deletingItem;
    var userToken = Provider.of<LoginProvide>(context).user.token;
    var items =
        Provider.of<LoginProvide>(context).provideBusketItems.data.basket;
    var provider = Provider.of<LoginProvide>(context);
    amount = items[widget.i].amount;
    final image = CachedNetworkImage(
      imageUrl: items[widget.i].images,
      fit: BoxFit.scaleDown,
    );
    final headerRow = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                items[widget.i].content,
              )),
          Text('${amount * int.parse(
                items[widget.i].price,
              )} ₸')
        ]);
    final controlsRow = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                if (amount > 1) {
                  provider.changeCrement(
                    false,
                    items[widget.i].basketId,
                    int.parse(items[widget.i].price),
                  );
                  setState(() {
                    if (timer.isActive) timer.cancel();
                    timer = Timer(Duration(milliseconds: 600), () {
                      Provider.of<LoginProvide>(context, listen: false)
                          .changeValue(
                        userToken,
                        amount,
                        items[widget.i].basketId,
                      );
                    });
                  });
                } else {
                  showPlatformDialog(
                    context: context,
                    builder: (_) => BasicDialogAlert(
                      title: Text(
                        "Вы уверены, что хотите удалить товар?",
                      ),
                      actions: <Widget>[
                        BasicDialogAction(
                          title: Text(
                            "Отмена",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        BasicDialogAction(
                          title: isDeleting != -1
                              ? LoadingCircle()
                              : Text(
                                  "Да",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                          onPressed: () {
                            Provider.of<LoginProvide>(context, listen: false)
                                .makeDelete(
                              items[widget.i].basketId,
                            );
                            setState(() {
                              amount = 0;
                              Provider.of<LoginProvide>(context, listen: false)
                                  .deleteItem(userToken,
                                      items[widget.i].basketId, context);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(Icons.indeterminate_check_box,
                  color: Theme.of(context).primaryColor, size: 30)),
          Text(amount.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              )),
          IconButton(
              onPressed: () {
                provider.changeCrement(true, items[widget.i].basketId,
                    int.parse(items[widget.i].price));
                setState(() {
                  if (timer.isActive) timer.cancel();
                  timer = Timer(Duration(milliseconds: 600), () {
                    Provider.of<LoginProvide>(context, listen: false)
                        .changeValue(
                      userToken,
                      amount,
                      items[widget.i].basketId,
                    );
                  });
                });
              },
              icon: Icon(Icons.add_box,
                  color: Theme.of(context).primaryColor, size: 30))
        ]);
    final content = Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [headerRow, controlsRow]));
    return Column(children: [
      Container(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Expanded(child: image, flex: 1),
            Expanded(child: content, flex: 2),
          ])),
      Divider(),
    ]);
  }
}
//ListView(
//padding: EdgeInsets.all(16),
//children: [
//persons,
//...getAllProducts(provideBusket),
//Container(
//width: w,
//child: Row(
//mainAxisAlignment:
//MainAxisAlignment.spaceBetween,
//children: [
//Text(
//'Самовывоз',
//style: TextStyle(
//color: Colors.black, fontSize: 18),
//),
//Switch(
//value: samvyvoz,
//onChanged: (v) {
//setState(() {
//samvyvoz = v;
//});
//},
//activeColor: Theme.of(context).primaryColor,
//)
//],
//),
//),
//Divider(),
//CustomTextField(
//hintText: 'Коментарии к заказу',
//onChanged: (val){
//provide.changeDeliverMap('comment', val);
//},
//),
//Divider(),
//],
//),
