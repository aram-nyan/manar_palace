import 'package:alux/pages/ProfilePage.dart';
import 'package:alux/services/ListViewProvide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AluxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;

  AluxAppBar({Key key, this.bottom}) : super(key: key);

  Widget build(BuildContext context) {
    var provide = Provider.of<ListViewProvider>(context);
    return AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed(ProfilePage.id),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              provide.setSearch();
            },
          )
        ],
        title: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/logo.png', fit: BoxFit.cover)),
        centerTitle: true,
        bottom: bottom,
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0), size: 21),
        elevation: 4);
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(85.0 + (bottom?.preferredSize?.height ?? 0.0));
}
