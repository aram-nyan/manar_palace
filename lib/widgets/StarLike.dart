import 'package:alux/services/LoginProvide.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatefulWidget {
  final int id;
  LikeButton({
    this.id,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    var ids = Provider.of<LoginProvide>(context).favouriteArray;
    var favIds = Provider.of<LoginProvide>(context).favIdJustId;
    var user = Provider.of<LoginProvide>(context).user;
    var isAdding = Provider.of<LoginProvide>(context).addingFavItem;
    return GestureDetector(
      onTap: () {
        if (user != null && user.token != '') {
          if (ids.contains(widget.id) == false) {
            Provider.of<LoginProvide>(context, listen: false)
                .addFav(user.token, widget.id, context);
          } else {
            var favId;
            favIds.forEach((element) {
              var kV = element.split(':');
              if (kV[0] == widget.id.toString()) {
                favId = int.parse(kV[1]);
                return favId;
              }
            });
            Provider.of<LoginProvide>(context, listen: false)
                .deleteFav(user.token, favId, widget.id, context);
          }
        } else {
          Provider.of<LoginProvide>(context, listen: false).showLoseConnection(
              context,
              'Нужна авторизация',
              'эта функция доступна только авторизованным пользователям',
              true);
        }
        setState(() {});
      },
      child: isAdding == widget.id
          ? LoadingCircle()
          : Icon(
              ids.contains(widget.id) ? Icons.star : Icons.star_border,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
    );
  }
}
