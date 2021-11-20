// ignore_for_file: file_names
import 'package:aamen/screens/paitentHome.dart';
import 'package:aamen/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Req.dart';
import 'widgets/CustomLabel.dart';
import 'widgets/CustomTextField.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  Users? u;
  List<Req> req = [];
  int _index = 0;
  bool isChecked = true;
  String email = '';
  String name = '';
  String phoneNumber = '';
  String comp = '';
  String password = '';
  String vPassword = '';
  String nationalId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تسجيل'),
        ),
        body: Stepper(
          currentStep: _index,
          onStepContinue: () {
            print(vPassword);
            print(_index);

            if (_index < 7) {
              setState(() {
                if (_index + 1 == 6) {
                  if (isChecked) {
                    _index += 1;
                  } else {
                    _index += 2;
                  }
                } else {
                  _index += 1;
                }
              });
            } else if (_index == 7) {
              sighnup(name, email, password, phoneNumber, nationalId, comp,
                  isChecked);
            }
          },
          steps: <Step>[
            Step(
              title: CustomLabel(text: 'الاسم'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'فلان الفلاني',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'الايميل'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email@gmail.com',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'كلمة المرور'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '*********',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'اعادة كلمة المرور'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    vPassword = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '*********',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'رقم السجل المدني'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    nationalId = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '11XXXXXXX',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'تملك تأمين؟'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('نعم'),
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'اسم شركة التأمين'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    comp = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'التعاونية',
                  ),
                ),
              ),
            ),
            Step(
              title: CustomLabel(text: 'رقم الهاتف'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  onChanged: (text) {
                    phoneNumber = text;
                  },
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '05xxxxxxxx',
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void sighnup(
    String name,
    String email,
    String password,
    String phoneNumber,
    String id,
    String comp,
    bool isChecked,
  ) async {
    try {
      await Firebase.initializeApp();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentReference users =
          FirebaseFirestore.instance.collection('patients').doc(id);
      users.set({
        'name': name, // John Doe
        'company': comp, // Stokes and Sons
        'd': id,
        'haveComp': isChecked,
        'phoneNumber': phoneNumber,
        'email': email,
        'dBudget': 0,
        'bBudget': 0,
        'eBudget': 0,
        'totalBudget': 0,

        // 42
      }).then((value) => {
            FirebaseFirestore.instance
                .collection('patients')
                .doc(id)
                .get()
                .then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                print(documentSnapshot.get('name'));
              }
            })
          });
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
          req.add(Req(
              status: doc['status'],
              title: doc['tilte'],
              budget: doc['budget']));
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => paitentHome(
                    requists: this.req,
                    user: this.u!,
                  )),
        );
      }).catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("لحظات بس نسوي الحساب")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
