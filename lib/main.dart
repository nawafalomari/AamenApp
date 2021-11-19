import 'package:flutter/material.dart';

void main() {
  runApp(AamenMain());
}

class AamenMain extends StatelessWidget {
  const AamenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Aamen!'),
      ),
      body: Center(
        child: Text("hello world form aamen :>")
      ),
    ),
    );
  }
}
