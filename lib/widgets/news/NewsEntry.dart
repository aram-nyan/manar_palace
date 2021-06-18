import 'package:alux/data/NewsData.dart';
import 'package:alux/models/News.dart';
import 'package:alux/widgets/news/NewsDetails.dart';
import 'package:flutter/material.dart';

class NewsEntry extends StatelessWidget {
  final NewsSingle entry;

  NewsEntry({
    Key key,
    this.entry,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final image = Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Image.network(
          entry.images,
          fit: BoxFit.cover,
          height: 120,
        ));
    final info = Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     color: Colors.grey.withOpacity(0.4)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  entry.createdAt
                      .toString()
                      .substring(0, entry.createdAt.toString().indexOf(' ')),
                  style:
                      TextStyle(color: Color.fromRGBO(0x5F, 0x5F, 0x5F, 1.0))),
              Text(entry.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(entry.content,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
            ]));

    return Container(
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (_) => NewsDetails(entry: entry),
          isScrollControlled: true,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: image, flex: 1),
            Expanded(child: info, flex: 2),
          ],
        ),
      ),
    );
  }
}
