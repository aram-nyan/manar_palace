import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final hintText;
  final prefixIcon;
  final onChanged;
  final obscure;
  final textCtr;
  final padding;
  final headText;

  CustomTextField({this.hintText, this.prefixIcon, this.obscure,this.onChanged,this.textCtr,this.headText,this.padding});
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(bottom:padding ?? 12),
      child: Container(
        width: w -32,
        height: 40,
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
              hintText: hintText,
            hintMaxLines: 2
          ),
        ),
      ),
    );
  }
}
