import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/CategoryFabricat.dart';
import 'package:alux/services/ListViewProvide.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/utils/TabPageFabrik.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';
import 'package:alux/widgets/product/ProductList.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key key}) : super(key: key);

  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ListViewProvider>(context, listen: false).fetchFabricat();
  }

  @override
  Widget build(BuildContext context) {
    List<CategoriesModelFabricat> categoriesFabrikat =
        Provider.of<ListViewProvider>(context).categoriesFabrikat;
    // var provide = ;
    var snapshot = Provider.of<ListViewProvider>(context).categoriesFabrikat;
    if (snapshot != null && snapshot.length > 0) {
      return TabPageFabril(
        content: ListView.builder(
          itemBuilder: (context, i) {
            return AutoScrollTag(
              controller:
                  Provider.of<ListViewProvider>(context).controllerFabril,
              key: ValueKey(i),
              index: i,
              child: getProducts(i, categoriesFabrikat[i]),
            );
          },
          itemCount: categoriesFabrikat.length,
          controller: Provider.of<ListViewProvider>(context).controllerFabril,
        ),
      );
    } else {
      return AppPage(
          content: Center(
        child: Text(
          'Coming Soon!',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ));
    }
  }
}

ProductList getProducts(int i, final CategoriesModelFabricat category) {
  var children = ProductList(
    header: category.categoryName,
    entries: List.generate(
      category.categories.products.length,
      (index) => ProductModel(
          id: category.categories.products[index].id,
          title: category.categories.products[index].title,
          price: category.categories.products[index].price,
          content: category.categories.products[index].content,
          images: category.categories.products[index].images),
    ),
  );
  return children;
}
