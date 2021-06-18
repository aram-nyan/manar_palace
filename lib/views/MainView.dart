import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/services/ListViewProvide.dart';
import 'package:alux/utils/Page.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:alux/widgets/product/ProductPreview.dart';
import 'package:flutter/material.dart';

import 'package:alux/widgets/product/ProductList.dart';

import 'package:alux/utils/TabPage.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget build(BuildContext context) {
    var provide = Provider.of<ListViewProvider>(context);
    var snapshot = Provider.of<ListViewProvider>(
      context,
    ).categoriesModel;
    return snapshot != null && snapshot.length > 0
        ? TabPage(
            content: ListView.builder(
              itemBuilder: (context, i) {
                return AutoScrollTag(
                  controller: provide.controller,
                  key: ValueKey(i),
                  index: i,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Text(provide.categoriesModel[i].categoryName,
                                style: Theme.of(context).textTheme.headline2)),
                      )
                    ]
                        .followedBy(
                            provide.categoriesModel[i].categories.products
                                .map<Widget>((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProductEntry(entry: e),
                                    ))
                                .toList())
                        .toList(),
                  ),
                );
              },
              itemCount: provide.categoriesModel.length,
              controller: provide.controller,
            ),
          )
        : AppPage(content: LoadingCircle());
  }
}

Future<Widget> returnOneColumn(CategoriesModel categoriesModel) async {
  var header =
      List.generate(categoriesModel.categories.products.length, (index) {
    return ProductModel(
        id: categoriesModel.categories.products[index].id,
        title: categoriesModel.categories.products[index].title,
        price: categoriesModel.categories.products[index].price,
        content: categoriesModel.categories.products[index].content,
        images: categoriesModel.categories.products[index].images);
  });
  return ProductList(
    header: categoriesModel.categoryName,
    entries: header,
  );
}

//TabPage(
//tabs: tabs,
//views: tabs.map<Widget>((tab) => ListView(
//padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//children: [
//ProductList(
//header: tab.header,
//entries: List.generate(5, (index) => createProduct())
//),
//ProductList(
//header: tab.header,
//entries: List.generate(5, (index) => createProduct())
//)
//]
//)).toList()
//)

//
//views: tabs.map<Widget>((tab) => ListView(
//padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//children: [
//ProductList(
//header: tab.header,
//entries: List.generate(5, (index) => createProduct())
//),
//ProductList(
//header: tab.header,
//entries: List.generate(5, (index) => createProduct())
//)
//]
//)).toList()
