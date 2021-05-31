import 'package:alux/widgets/LoadCircle.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
final String label;
final VoidCallback onPressed;
final trigger;
final white;
final enable;
  AppButton({ Key key, this.label, this.onPressed, this.trigger,this.enable,this.white}) : super(key: key);

  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      color:(enable ?? true) ?  Theme.of(context).primaryColor : Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: (trigger ?? false) == false ? Text(label,
        style: TextStyle(
          color: Theme.of((context)).textTheme.bodyText1.color,
          fontWeight: FontWeight.w600,
          fontSize: 16
        )
      ) : LoadingCircle(white: white ?? false,),
    );
  }
}