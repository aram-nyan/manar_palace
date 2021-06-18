import 'dart:async';
import 'dart:convert';
import 'package:alux/data/Product.dart';
import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/models/CopyCategories.dart';
import 'package:alux/models/News.dart';
import 'package:alux/models/Products.dart';
import 'package:alux/models/user.dart';
import 'package:alux/utils/TabPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_to_index/scroll_to_index.dart';

class NewsViewProvider extends ChangeNotifier {
  StreamController<int> listController = StreamController<int>();
  List<NewsSingle> newsModel = [];

  List<CategoriesModelCopy> _copyConst = [];
  AutoScrollController controller;
  NewsViewProvider() {
    controller = AutoScrollController(
      initialScrollOffset: 0,
      axis: Axis.vertical,
    );
  }
  var isFirstAttemt = true;
  Future<List<NewsSingle>> fetchAllNews() async {
    try {
      if (isFirstAttemt) {
        final respCategory = await http
            .get(
              'https://manapolise.a-lux.dev/api/news/catalog',
            )
            .catchError((e) => print(e));
        News allNees;
        if (respCategory.statusCode == 200) {
          var jsonResp = json.decode(respCategory.body);
          allNees = News.fromJson(jsonResp);
          notifyListeners();
          isFirstAttemt = false;
          newsModel = allNees.data;
          notifyListeners();
          return newsModel;
        } else {
          print(respCategory.statusCode);
        }
        return newsModel;
      }
    } catch (e) {
      print(e);
    }
    print(_copyConst.length.toString() + ' copu const');
    return newsModel;
  }
}
