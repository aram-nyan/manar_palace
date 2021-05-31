import 'package:alux/data/NewsData.dart';
import 'package:alux/models/News.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final NewsSingle entry;


  NewsDetails({ Key key, this.entry,  }) : super(key: key);


  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(entry.images, height: 80, fit: BoxFit.cover),
          Text(entry.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            )
          ),
          Text(entry.content,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            )
          )
        ]
      )
    );
  }
}