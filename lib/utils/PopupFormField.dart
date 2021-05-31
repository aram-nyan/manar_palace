import 'package:flutter/material.dart';

class PopupFieldEntry<T> {
  final T value;
  final String label;

  PopupFieldEntry(this.value, this.label);
}

class PopupFormField<T> extends FormField<T> {
  final T initialValue;
  final List<PopupFieldEntry<T>> entries;
  final String label;


  PopupFormField({
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator, 
    bool autovalidate = false, 

    void Function(T) onChanged,
    this.label, 
    this.initialValue,
    this.entries
  }) : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autovalidate,


    builder: (FormFieldState<T> state) {
      final current = entries.firstWhere((element) => element.value == state.value);

      return InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label),
            Spacer(),
            Text(current.label),
            Icon(Icons.arrow_drop_down)
          ],
        ),
        onTap: () async {
          final newValue = await showDialog<T>(
            context: state.context,
            builder: (_) => _PopUpFieldDialog(
              label: label,
              initialValue: initialValue,
              entries: entries,
            )
          );

          if (newValue != null) {
            state.didChange(newValue);
            onChanged(newValue);
          }
        }
      );
    }
  );
}


class _PopUpFieldDialog<T> extends StatefulWidget {
  
  final String label;
  final T initialValue; 
  final List<PopupFieldEntry<T>> entries;

  const _PopUpFieldDialog({Key key, this.initialValue, this.entries, this.label}) : super(key: key); 

  @override
  State<StatefulWidget> createState() {
    return _PopUpFieldDialogState();
  }

}

class _PopUpFieldDialogState<T> extends State<_PopUpFieldDialog<T>> {

  T _value; 

  initState() {
    super.initState();

    _value = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.label),
      children: widget.entries
        .map<Widget>((entry) => ListTile(
          title: Text(entry.label),
          leading: Radio<T>(
            value: entry.value,
            groupValue: _value,
            onChanged: (T value) => setState(() { _value = value; }),
          ),
        ))
        .followedBy([
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text('ОТМЕНА'),
                onPressed: () => Navigator.of(context).pop(null)
              ),
              FlatButton(
                child: Text('ВЫБРАТЬ'),
                onPressed: () => Navigator.of(context).pop(_value)
              )
            ]
          )
        ])
        .toList()
    );
  }

}