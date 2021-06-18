import 'dart:async';
import 'dart:convert';
import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/CategoryFabricat.dart';
import 'package:alux/models/CopuFabricat.dart';
import 'package:alux/models/CopyCategories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_to_index/scroll_to_index.dart';

class ListViewProvider extends ChangeNotifier {
  StreamController<int> listController = StreamController<int>();
  List<CategoriesModel> categoriesModel = [];
  List<CategoriesModelFabricat> categoriesFabrikat = [];
  List<CategoriesModelCopy> _copyConst = [];
  List<FabricatCategoriesModelCopy> _copyConstFabricat = [];
  AutoScrollController controllerFabril;
  AutoScrollController controller;
  ListViewProvider() {
    initiate();
    controller = AutoScrollController(
      initialScrollOffset: 0,
      axis: Axis.vertical,
    );
    controllerFabril = AutoScrollController(
      initialScrollOffset: 0,
      axis: Axis.vertical,
    );
    fetchFabricat();
  }
  Future initiate() async {
    categoriesModel = await fetchAllCategories();
    notifyListeners();
  }

  void goToIndex(i) async {
    controller.scrollToIndex(i,
        duration: Duration(milliseconds: 300),
        preferPosition: AutoScrollPosition.begin);
    listController.add(i);
    notifyListeners();
  }

  void goToIndexFabrik(i) async {
    controllerFabril.scrollToIndex(i,
        duration: Duration(milliseconds: 300),
        preferPosition: AutoScrollPosition.begin);
    notifyListeners();
  }

  Future<List<CategoriesModel>> fetchAllCategories() async {
    try {
      final respCategory = await http
          .get(
            'https://manapolise.a-lux.dev/api/catalogs/all',
          )
          .catchError((e) => print(e));
      AllProductsModel allProducts;
      if (respCategory.statusCode == 200) {
        var jsonResp = json.decode(respCategory.body);
        allProducts = AllProductsModel.fromJson(jsonResp);
        notifyListeners();
        categoriesModel = allProducts.data;
        _copyConst = AllProductsModelCopy.fromJson(jsonResp).data;
        notifyListeners();
        return categoriesModel;
      } else {}
      return categoriesModel;
    } catch (e) {
      print(e);
    }
    return categoriesModel;
  }

  Future<List<CategoriesModelFabricat>> fetchFabricat() async {
    try {
      final respCategory = await http
          .get(
            'https://manapolise.a-lux.dev/api/catalogs/type/1',
          )
          .catchError((e) => print(e));
      FabricatAll allProducts;
      if (respCategory.statusCode == 200) {
        var jsonResp = jsonDecode(respCategory.body);
        print(respCategory.body);
        allProducts = FabricatAll.fromJson(jsonResp);
        notifyListeners();
        categoriesFabrikat = allProducts.data;
        _copyConstFabricat = FabricatProductsModelCopy.fromJson(jsonResp).data;

        notifyListeners();
        return categoriesFabrikat;
      } else {}
      return categoriesFabrikat;
    } catch (e) {
      print(e);
    }
    return categoriesFabrikat;
  }

  bool isSearchMode = false;
  void setSearch() {
    isSearchMode = !isSearchMode;
    notifyListeners();
  }

  List<CategoriesModel> getIt(List<CategoriesModel> dummy, String query) {
    List<CategoriesModel> hell = [];
    hell.addAll(dummy);
    dummy.forEach((element) {
      var newList = element.categories.products
          .where((e) => e.title.contains(query))
          .toList();
      hell.forEach((elnt) {
        if (element.categoryName == elnt.categoryName) {
          elnt.categories.products = newList;
        }
      });
    });
    return hell;
  }

  List<CategoriesModelFabricat> getItFabrikat(
      List<CategoriesModelFabricat> dummy, String query) {
    List<CategoriesModelFabricat> hell = [];
    hell.addAll(dummy);
    dummy.forEach((element) {
      var newList = element.categories.products
          .where((e) => e.title.contains(query))
          .toList();
      hell.forEach((elnt) {
        if (element.categoryName == elnt.categoryName) {
          elnt.categories.products = newList;
        }
      });
    });
    return hell;
  }

  void filterSearchResultsFabricat(String query) {
    try {
      List<CategoriesModelFabricat> dummySearchList = [];
//      dummySearchList.addAll(_copyConst);
      _copyConstFabricat.forEach((element) {
        List<ProductModelFabrikat> newListProduct = [];
        element.categories.products.forEach((product) {
          ProductModelFabrikat productnew;
          productnew = ProductModelFabrikat(
            content: product.content,
            title: product.title,
            price: product.price,
            edMassa: product.edMassa,
            edMassa2: product.edMassa2,
            images: product.images,
            id: product.id,
            catalogId: product.catalogId,
          );
          newListProduct.add(productnew);
        });
        CategoriesModelFabricat newCategory = CategoriesModelFabricat(
            categories: CategoriesFabrikat(products: newListProduct),
            categoryName: element.categoryName);
        dummySearchList.add(newCategory);
      });

      if (query.isNotEmpty) {
        categoriesFabrikat = getItFabrikat(dummySearchList, query);
        notifyListeners();
        return;
      } else {
        categoriesFabrikat.clear();
        List<CategoriesModelFabricat> newBackup = [];
        _copyConstFabricat.forEach((element) {
          List<ProductModelFabrikat> newListProduct = [];
          element.categories.products.forEach((product) {
            ProductModelFabrikat productnew;
            productnew = ProductModelFabrikat(
              content: product.content,
              title: product.title,
              price: product.price,
              edMassa: product.edMassa,
              edMassa2: product.edMassa2,
              images: product.images,
              id: product.id,
              catalogId: product.catalogId,
            );
            newListProduct.add(productnew);
          });
          CategoriesModelFabricat newCategory = CategoriesModelFabricat(
              categories: CategoriesFabrikat(products: newListProduct),
              categoryName: element.categoryName);
          newBackup.add(newCategory);
        });
        categoriesFabrikat.addAll(newBackup);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void filterSearchResults(String query) {
    try {
      List<CategoriesModel> dummySearchList = [];
      _copyConst.forEach((element) {
        List<ProductModel> newListProduct = [];
        element.categories.products.forEach((product) {
          ProductModel productnew;
          productnew = ProductModel(
            content: product.content,
            title: product.title,
            price: product.price,
            edMassa: product.edMassa,
            edMassa2: product.edMassa2,
            images: product.images,
            id: product.id,
            catalogId: product.catalogId,
          );
          newListProduct.add(productnew);
        });
        CategoriesModel newCategory = CategoriesModel(
            categories: Categories(products: newListProduct),
            categoryName: element.categoryName);
        dummySearchList.add(newCategory);
      });

      if (query.isNotEmpty) {
        categoriesModel = getIt(dummySearchList, query);
        notifyListeners();
        return;
      } else {
        categoriesModel.clear();
        List<CategoriesModel> newBackup = [];
        _copyConst.forEach((element) {
          List<ProductModel> newListProduct = [];
          element.categories.products.forEach((product) {
            ProductModel productnew;
            productnew = ProductModel(
              content: product.content,
              title: product.title,
              price: product.price,
              edMassa: product.edMassa,
              edMassa2: product.edMassa2,
              images: product.images,
              id: product.id,
              catalogId: product.catalogId,
            );
            newListProduct.add(productnew);
          });
          CategoriesModel newCategory = CategoriesModel(
              categories: Categories(products: newListProduct),
              categoryName: element.categoryName);
          newBackup.add(newCategory);
        });
        categoriesModel.addAll(newBackup);
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
