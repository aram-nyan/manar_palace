import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget { 
  final int currentIndex;
  final void Function(int) onTap;

  AppBottomBar({ Key key, this.currentIndex, this.onTap }) : super(key: key);


  Widget build(BuildContext context) {
    return BottomNavigationBar( 
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
            title: Text('Главное')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.loyalty),
            title: Text('Магазин')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storage),
            title: Text('Новости')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Избранные')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('Корзиа')
        ),
      ]
    );
  }
}
