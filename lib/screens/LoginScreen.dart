// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'widgets/CustomLabel.dart';
import 'widgets/CustomTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLabel(text: 'البريد الالكتروني'),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  placeHolder: "exmaple@exmaple.com",
                  isPassword: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomLabel(text: 'كلمة المرور'),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  placeHolder: '********',
                  isPassword: true,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    print('sighn up');
                  },
                  child: Text('ما عندك حساب؟ سجّل'),
                )
              ],
            ),
          ),
        ));
  }
}
