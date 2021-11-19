import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String placeHolder;
  bool isPassword;

  CustomTextField({
    this.isPassword = false,
    this.placeHolder = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        obscureText: isPassword,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: placeHolder,
        ),
      ),
    );
  }
}
