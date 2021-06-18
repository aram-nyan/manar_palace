import 'package:alux/data/CartEntry.dart';
import 'package:alux/data/Product.dart';
import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:alux/widgets/StarLike.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel entry;

  ProductDetails({
    Key key,
    this.entry,
  }) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var count = 1;
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
        height: MediaQuery.of(context).size.height / 4,
        placeholder: (context, url) => Image.asset('assets/logo.png'),
      ),
    );
    final info = Container(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        margin: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.entry.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (widget.entry.content != null)
              Text(widget.entry.content,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))
          ],
        ));
    final controls = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove,
                          color: Theme.of(context).primaryColor, size: 30),
                      onPressed: () {
                        setState(() {
                          if (count > 1) {
                            count--;
                          }
                        });
                      },
                    ),
                    Text(count.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        )),
                    IconButton(
                      icon: Icon(Icons.add_box,
                          color: Theme.of(context).primaryColor, size: 30),
                      onPressed: () {
                        setState(() {
                          count++;
                        });
                      },
                    ),
                  ]),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  provide.addToBusket(
                      widget.entry.id, user.token, context, count);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: provide.isAddingItem == widget.entry.id
                    ? LoadingCircle(
                        white: true,
                      )
                    : Text(
                        'Добавить ${int.parse(widget.entry.price) * count} ₸',
                        style: TextStyle(
                            color:
                                Theme.of((context)).textTheme.bodyText1.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
              )
            ]));
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Stack(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [image, info, controls]),
            Positioned(
                top: 16,
                right: 24,
                child: LikeButton(
                  id: widget.entry.id,
                )),
          ],
        ));
  }
}
