import 'package:aamen/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aamen/screens/paitentHome.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;

void main() {
  runApp(AamenMain());
}

class AamenMain extends StatelessWidget {
  const AamenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: paitentHome(),
    );
  }
}
