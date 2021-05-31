import 'package:alux/models/AllProdcutsModel.dart';
import 'package:flutter/material.dart';

import 'package:alux/data/Product.dart';

import 'ProductPreview.dart';

class ProductList extends StatelessWidget {
  final String header;
  final List<ProductModel> entries;
  
  ProductList({ Key key, this.header, this.entries }) : super(key: key);


  Widget build(BuildContext context) {
    final products = entries.map<Widget>((e) => ProductEntry(entry: e)).toList();
    
    final header = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Text(this.header, style: Theme.of(context).textTheme.headline2)
    );

    final children = <Widget>[header].followedBy(products)
      .map<Widget>((e) => Padding(child: e, padding: const EdgeInsets.all(8)))
      .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children
    );
  }
}