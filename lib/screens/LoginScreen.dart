// ignore_for_file: file_names
import 'package:aamen/Req.dart';
import 'package:aamen/screens/Register.dart';
import 'package:aamen/screens/paitentHome.dart';
import 'package:aamen/user.dart';
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
  Users? u = null;
  List<Req> requests = [];
  Color col = Color(0x00000000);
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff2f3f7),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2470c7),
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(70),
                  bottomRight: const Radius.circular(70),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              _buildContainer(),
              CircularProgressIndicator(color: col),
              _buildSignUpBtn(),
            ],
          )
        ],
      ),
    );
  }

  void sighnin(String email, String password) async {
    try {
      await Firebase.initializeApp();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('patients')
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        value.docs.forEach((doc) {
          this.u = Users(
              phoneNumber: doc['phoneNumber'],
              bBudget: doc['bBudget'],
              company: doc['company'],
              dBudget: doc['dBudget'],
              eBudget: doc['eBudget'],
              email: doc['email'],
              id: doc['d'],
              name: doc['name'],
              totalBudget: doc['totalBudget']);
        });

        ;
      });
      await FirebaseFirestore.instance
          .collection('req')
          .where('user', isEqualTo: u!.id)
          .get()
          .then((value) {
        value.docs.forEach((doc) {
          requests.add(Req(
              status: doc['status'],
              title: doc['tilte'],
              budget: doc['budget']));
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => paitentHome(
                    requists: this.requests,
                    user: this.u!,
                  )),
        );
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

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            ' تطبيق آمن',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter an email id';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email), labelText: 'example@gmail.com'),
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 6) {
            return 'Password should contain more than 5 characters';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: '***********',
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.blue,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: style,
            onPressed: () {
              if (email != '' && password != '') {
                setState(() {
                  col = Colors.blue;
                });
                sighnin(email, password);
              }
            },
            child: Text(
              "تسجيل دخول",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Text(
            '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "سجل دخول",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    ),
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _buildLoginButton(),
                _buildOrRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'ماعندك حساب؟   ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                    text: 'سجل',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
