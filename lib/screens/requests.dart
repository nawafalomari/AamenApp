import 'package:aamen/Req.dart';
import 'package:aamen/screens/widgets/infoCard.dart';
import 'package:aamen/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aamen/const.dart';
import 'package:aamen/screens/widgets/card_items.dart';
import 'package:aamen/screens/widgets/card_main.dart';
import 'package:aamen/screens/widgets/card_section.dart';
import 'package:aamen/screens/widgets/custom_clipper.dart';

import 'LoginScreen.dart';

class requests extends StatefulWidget {
  Users user;

  requests({required this.user, Key? key}) : super(key: key);

  @override
  _requests createState() => _requests();
}

class _requests extends State<requests> {
  @override
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    print(((widget.user.dBudget / 2000) * 100).toInt());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "اهلاً مجدداً\n" + widget.user.name,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          sighnOut();
                        })
                  ],
                ),

                SizedBox(height: 50),
                Container(
                  child: Center(
                      child: Column(
                    children: [
                      infoCard(widget.user.name),
                      infoCard(widget.user.id),
                      infoCard(widget.user.email),
                      infoCard(widget.user.company),
                    ],
                  )),
                ),

                // Main Cards - Heartbeat and Blood Pressure
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> sighnOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
