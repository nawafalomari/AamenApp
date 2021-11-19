import 'package:aamen/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AamenMain());
}

class AamenMain extends StatelessWidget {
  const AamenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
