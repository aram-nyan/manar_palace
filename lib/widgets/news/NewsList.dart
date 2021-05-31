import 'package:alux/models/News.dart';
import 'package:flutter/material.dart';

import 'package:alux/data/NewsData.dart';

import 'NewsEntry.dart';

class NewsList extends StatelessWidget {
  final String header;
  final List<NewsSingle> entries;
  
  NewsList({ Key key, this.header, this.entries }) : super(key: key);


  Widget build(BuildContext context) {
    final children = entries
      .map<Widget>((e) => NewsEntry(entry: e))
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