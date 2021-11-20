import 'package:aamen/Req.dart';
import 'package:aamen/screens/LoginScreen.dart';
import 'package:aamen/screens/paitentHome.dart';
import 'package:aamen/screens/requests.dart';
import 'package:aamen/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  Users? u = null;
  List<Req> requests = [];

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      print(FirebaseAuth.instance.currentUser);
      if (FirebaseAuth.instance.currentUser != null) {
        print('not Null');
        await FirebaseFirestore.instance
            .collection('patients')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((value) {
          value.docs.forEach((doc) {
            u = Users(
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
        });

        print(u!.id);
        await FirebaseFirestore.instance
            .collection('req')
            .where('user', isEqualTo: u!.id)
            .get()
            .then((value) {
          print(value.docs);
          value.docs.forEach((doc) {
            print(doc['tilte']);
            print('hello');
            print(doc['tilte'] + 'added');
            requests.add(Req(
                status: doc['status'],
                title: doc['tilte'],
                budget: doc['budget']));
          });
        });
      }
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed

    // Show a loader until FlutterFire is initialized

    return FutureBuilder(
      // Initialize FlutterFire
      future: initializeFlutterFire(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return LoginScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (FirebaseAuth.instance.currentUser != null) {
            return MaterialApp(
              home: paitentHome(
                requists: this.requests,
                user: u!,
              ),
            );
          } else {
            return MaterialApp(
              home: LoginScreen(),
            );
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
    // if (FirebaseAuth.instance.currentUser != null) {

    //   return MaterialApp(
    //     home: paitentHome(
    //       requists: this.requests,
    //       user: u!,
    //     ),
    //   );
    // }

    // return MaterialApp(
    //   home: LoginScreen(),
    // );
  }
}
