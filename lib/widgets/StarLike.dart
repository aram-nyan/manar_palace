import 'package:alux/services/LoginProvide.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LikeButton extends StatelessWidget {
  final int id;
  LikeButton({this.id,});
  @override
  Widget build(BuildContext context) {
    var ids = Provider.of<LoginProvide>(context).favouriteArray;
    var favIds = Provider.of<LoginProvide>(context).favIdJustId;
    var user = Provider.of<LoginProvide>(context).user;
    var isAdding = Provider.of<LoginProvide>(context).addingFavItem;
    return GestureDetector(
      onTap: () {
        if (user != null && user.token != '') {
          if (ids.contains(id) == false) {
            Provider.of<LoginProvide>(context, listen: false).addFav(
                user.token, id, context);
          } else {
            var favId;
            favIds.forEach((element) {
              var kV = element.split(':');
              if (kV[0] == id.toString()) {
                favId = int.parse(kV[1]);
                return favId;
              }
            });
            Provider.of<LoginProvide>(context, listen: false).deleteFav(
                user.token, favId, id, context);
          }
        }else{
          Provider.of<LoginProvide>(context,listen: false).showLoseConnection(context, 'Нужна авторизация', 'эта функция доступна только авторизованным пользователям', true);
        }
      },
      child: isAdding == id ? LoadingCircle() :
      Icon(ids.contains(id) ? Icons.star : Icons.star_border,color: Theme.of(context).primaryColor,size: 30,),
    );
  }
}
