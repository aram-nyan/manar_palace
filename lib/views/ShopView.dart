import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/CategoryFabricat.dart';
import 'package:alux/services/ListViewProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/utils/TabPageFabrik.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';

import 'package:alux/data/Product.dart';
import 'package:alux/widgets/product/ProductList.dart';

import 'package:alux/utils/TabPage.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
 
class ShopView extends StatefulWidget {

  const ShopView({ Key key }) : super(key: key);

  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provide = Provider.of<ListViewProvider>(context,listen: false).fetchFabricat();
  }
  @override
  Widget build(BuildContext context) {
    var  provide = Provider.of<ListViewProvider>(context);
    var  snapshot = Provider.of<ListViewProvider>(context).categoriesFabrikat;
    return snapshot != null && snapshot.length > 0 ?
    TabPageFabril(
     content: ListView.builder(itemBuilder: (context,i){
       return AutoScrollTag(
         controller: provide.controllerFabril,
         key: ValueKey(i),
         index: i,
         child: getProducts(i,provide.categoriesFabrikat[i]),
       );
     },itemCount: provide.categoriesFabrikat.length,
       controller: provide.controllerFabril,
     ),
    ) : AppPage(
        content: LoadingCircle());;
  }

  ProductList getProducts (int i, final CategoriesModelFabricat category){
    var childrer = ProductList(
        header: category.categoryName,
        entries: List.generate(category.categories.products.length, (index) => ProductModel(
            id: category.categories.products[index].id,
            title:  category.categories.products[index].title,
            price:  category.categories.products[index].price,
            content: category.categories.products[index].content,
            images:  category.categories.products[index].images
        ))
    );
    return childrer;
  }

}