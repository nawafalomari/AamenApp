// ignore_for_file: file_names
import 'package:aamen/screens/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets/CustomLabel.dart';
import 'widgets/CustomTextField.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  static String userEmail = '';
  static String userName = '';
  static String comp = '';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
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
                  onFinish: (text) {
                    email = text;
                  },
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
                  onFinish: (text) {
                    password = text;
                  },
                  placeHolder: '********',
                  isPassword: true,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.red.shade200,
                  onPressed: () {
                    if (email != '' && password != '') {
                      sighnin(email, password);
                    }
                  },
                  child: Text('تسجيل دخول'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text('ما عندك حساب؟ سجّل'),
                )
              ],
            ),
          ),
        ));
  }

  void sighnin(String email, String password) async {
    try {
      await Firebase.initializeApp();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseFirestore.instance
          .collection('patients')
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        value.docs.forEach((doc) {
          print(doc["name"]);
        });
        ;
      });

      print(userCredential.user!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
