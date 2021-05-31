import 'package:flutter/material.dart';

class SingleAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title; 

  SingleAppBar({ Key key, this.title,  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 22
        )
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor)
      )
    );
  }
}