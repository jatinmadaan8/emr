import 'package:flutter/material.dart';

class CheckboxButtonCommon extends StatelessWidget {
  final Function selectHandler;
  final bool value;
  final String title;
  CheckboxButtonCommon(this.selectHandler, this.value, this.title);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Checkbox(
        value: value,
        onChanged: selectHandler,
        activeColor: Color.fromRGBO(45, 133, 185, 1),
      ),
      Text(
        title,
        style: new TextStyle(fontSize: 14.0),
      ),
    ]);
  }
}
