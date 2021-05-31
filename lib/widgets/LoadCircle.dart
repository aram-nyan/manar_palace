import 'package:flutter/material.dart';
class LoadingCircle extends StatelessWidget {
  final white;
  LoadingCircle({this.white});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 25,
          height: 25,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>((white?? false) ? Colors.white :  Color.fromRGBO(0xA8, 0x67, 0x26, 1.0))
            ),
          )),
    );
  }
}
