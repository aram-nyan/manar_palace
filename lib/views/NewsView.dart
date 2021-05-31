import 'package:alux/models/News.dart';
import 'package:alux/services/NewsService.dart';
import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';

import 'package:alux/data/NewsData.dart';
import 'package:alux/widgets/news/NewsList.dart';

import 'package:alux/utils/Page.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget { 

  const NewsView({ Key key }): super(key: key);

  @override
  Widget build(BuildContext context) {
    var future = Provider.of<NewsViewProvider>(context);
    return AppPage(
      content: FutureProvider<List<NewsSingle>>(
        create: (context)=> future.fetchAllNews(),
        child: Consumer<List<NewsSingle>>(
          builder: (context,snapshot, child) {
            return snapshot != null ? SingleChildScrollView(
              child: NewsList(
                entries: List.generate(snapshot.length, (index) => createNews(snapshot[index])),
              )
            ) : LoadingCircle();
          }
        ),
      )
    );
  }

  createNews(NewsSingle news) => NewsSingle(
    name: news.name,
    createdAt: news.createdAt,
    content: news.content,
    images: news.images,
  );
}