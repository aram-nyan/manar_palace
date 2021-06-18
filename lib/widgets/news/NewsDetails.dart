import 'package:alux/models/News.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final NewsSingle entry;

  NewsDetails({
    Key key,
    this.entry,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2.4;
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(entry.images, height: 220, fit: BoxFit.fitWidth),
            SizedBox(
              height: 15,
            ),
            Text(entry.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(entry.content,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
