import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final bool isAstric;
  CommonText(@required this.text, this.isAstric);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: isAstric
          ? Row(
              children: <Widget>[
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  ' *',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            )
          : Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
    );
  }
}
