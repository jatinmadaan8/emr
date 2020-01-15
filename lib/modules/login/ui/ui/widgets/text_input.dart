import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const AppTextInput(
      {Key key, this.controller, this.hint, this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(
          obscureText ? Icons.lock : Icons.person,
          color: Color(0xff9bd0e5)
        ),
        labelStyle: const TextStyle(color: Color(0xff9bd0e5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 0.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff9bd0e5)),
            borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff9bd0e5)),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
