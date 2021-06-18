import 'package:alux/models/AllProdcutsModel.dart';
import 'package:alux/widgets/product/ProductDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alux/data/Product.dart';

class ProductEntry extends StatelessWidget {
  final ProductModel entry;
  const ProductEntry({Key key, this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addButton = Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.add_circle_outline, size: 24)),
              SizedBox(
                width: 8,
              ),
              Text('${entry.price} ₸')
            ]));
    final info = Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: Container(
          width: (MediaQuery.of(context).size.width / 3 * 2) - 48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(
                height: 8,
              ),
              if (entry.content != null)
                Text(entry.content,
                    overflow: TextOverflow.clip,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              SizedBox(
                height: 8,
              ),
              addButton
            ],
          ),
        ));
    final image = CachedNetworkImage(
      memCacheHeight: 180,
      memCacheWidth: 200,
      fadeInDuration: const Duration(milliseconds: 400),
      filterQuality: FilterQuality.low,
      imageUrl: entry.images,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      height: 180,
      placeholder: (context, url) => Icon(Icons.fastfood),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    var h = MediaQuery.of(context).size.height;
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (_) => ProductDetails(
                    entry: entry,
                  ),
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              )),
          child: Container(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Expanded(child: info, flex: 2),
                Expanded(child: image, flex: 1)
              ])),
        ));
  }
}
