import 'package:flutter/material.dart';

class RadioButtonCommon extends StatelessWidget {
  final Function selectHandler;
  var selctedelivery;
  final String title;

  var index;
  RadioButtonCommon(
      this.selectHandler, this.selctedelivery, this.title, this.index);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<dynamic>(
          groupValue: selctedelivery,
          value: index,
          onChanged: selectHandler,
          activeColor: Color.fromRGBO(45, 133, 185, 1),
        ),
        Text(
          title,
          style: new TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
