import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/Favourite.dart';
import 'package:alux/models/HistoryOrders.dart';
import 'package:alux/pages/LoginPage.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:alux/widgets/product/ProductDetails.dart';
import 'package:alux/widgets/product/ProductHistoryDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryOrder extends StatefulWidget {
  static var id = 'historyorder';
  HistoryOrder({Key key}) : super(key: key);
  @override
  _HistoryOrderState createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  @override
  initState() {
    var provide = Provider.of<LoginProvide>(context, listen: false);
    var user = Provider.of<AuthProvide>(context, listen: false).user.token;
    provide.currentHitory(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvide>(context).user;
    var snap = Provider.of<LoginProvide>(context).historyOrders;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Мои Заказы',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
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
            : snap != null && snap.success
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                      child: ListView.separated(
                        itemBuilder: (context, i) {
                          final image = CachedNetworkImage(
                            imageUrl: snap.data[i].images,
                            fit: BoxFit.scaleDown,
                            placeholder: (context, url) =>
                                Image.asset('assets/logo.png'),
                            errorWidget: (context, String url, s) =>
                                Image.asset('assets/logo.png'),
                          );
                          final info = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap.data[i].createdAt ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                              Text(
                                snap.data[i].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                snap.data[i].content ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(snap.data[i].price.toString() + ' ₸')
                            ],
                          );
                          var entry = snap.data[i];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) =>
                                      ProductHistoryDetails(entry: entry),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50))));
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: info,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: image,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(8),
                        separatorBuilder: (context, i) => Divider(),
                        itemCount: snap.data.length,
                      ),
                    ),
                  )
                : snap != null && snap.success == false
                    ? Center(
                        child: Text(snap.message),
                      )
                    : LoadingCircle());
  }
}
//GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//crossAxisSpacing: 8,
//mainAxisSpacing: 24,
//childAspectRatio:(w/2-20)/340,
//crossAxisCount:  2 ), itemBuilder: (context, i){
//return SecondaryContainer(id: snap.data[i].id,name: snap.data[i].title,
//inFav: true,
//gram: snap.data[i].edMassa,
//image: snap.data[i].images,
//price: snap.data[i].price,
//content: snap.data[i].content,
//
//);
//},itemCount: snap.data.length,),
