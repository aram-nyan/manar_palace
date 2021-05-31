import 'package:alux/data/NewsData.dart';
import 'package:alux/models/News.dart';
import 'package:alux/widgets/news/NewsDetails.dart';
import 'package:flutter/material.dart';

class NewsEntry extends StatelessWidget {
  final NewsSingle entry;


  NewsEntry({ Key key,  this.entry,  }) : super(key: key);


  Widget build(BuildContext context) {
    final image = Container(
      padding: const EdgeInsets.all(15),
      child: Image.network(entry.images, fit: BoxFit.scaleDown)
    );

    final info = Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.createdAt.toString(),
            style: TextStyle(
              color: Color.fromRGBO(0x5F, 0x5F, 0x5F, 1.0)
            )
          ),

          Text(entry.name, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          )),

          Text(entry.content,
            overflow: TextOverflow.clip , 
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16
            )
          ),

        ]
      )
    );

    return Container(
      child: InkWell(
        onTap: () => showBottomSheet(
          context: context,
          builder: (_) => BottomSheet(
            builder: (_) => NewsDetails(entry: entry),
            
            onClosing: () {},
          )

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ Expanded(child: image, flex: 1), Expanded(child: info, flex: 2) ]
        )
      )
    ); 
  }
}