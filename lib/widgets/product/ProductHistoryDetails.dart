
import 'package:alux/models/HistoryOrders.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductHistoryDetails extends StatefulWidget {
  final Data entry;

  ProductHistoryDetails({ Key key, this.entry,  }) : super(key: key);

  @override
  _ProductHistoryDetailsState createState() => _ProductHistoryDetailsState();
}

class _ProductHistoryDetailsState extends State<ProductHistoryDetails> {
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvide>(context).user;
    var provide = Provider.of<LoginProvide>(context);
    final image = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.entry.images,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height/3,
        placeholder: (context,url) => Image.asset('assets/logo.png'),
      ),
    );
    final info = Container(
        padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
        margin: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.entry.name, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            )),

            if (widget.entry.content != null)
              Text(widget.entry.content, overflow: TextOverflow.clip , style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              )),
            SizedBox(height: 4,),
            Text('Количество: ' + widget.entry.amount.toString(), overflow: TextOverflow.clip , style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16
            )),
          ],
        )
    );
    final controls = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width-20,
                child: RaisedButton(
                  onPressed: () {
                    provide.addToBusket(int.parse(widget.entry.productId), user.token, context, widget.entry.amount);
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  child: provide.isAddingItem == int.parse(widget.entry.productId) ? LoadingCircle(white: true,) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Заказать снова ',
                          style: TextStyle(
                              color: Theme.of((context)).textTheme.bodyText1.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                      ),
                      Text('${(widget.entry.price) * widget.entry.amount} ₸',
                          style: TextStyle(
                              color: Theme.of((context)).textTheme.bodyText1.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          )
                      ),
                    ],
                  ),
                ),
              )
            ]
        )
    );
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)
            )
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ image, info, controls ]
        )
    );
  }
}