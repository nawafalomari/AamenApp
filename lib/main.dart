import 'package:aamen/screens/LoginScreen.dart';
import 'package:aamen/screens/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dataHandler.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aamen/screens/paitentHome.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;

void main() async {
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
