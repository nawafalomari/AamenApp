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

class analytics extends StatefulWidget {
  Users user;
  List<Req> req;
  analytics({required this.req, required this.user, Key? key})
      : super(key: key);

  @override
  _analyticsState createState() => _analyticsState();
}

class _analyticsState extends State<analytics> {
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

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage('assets/icons/heartbeat.png'),
                        title: " القلب",
                        value: "66",
                        unit: "bpm",
                        color: Constants.lightGreen,
                      ),
                      CardMain(
                          image: AssetImage('assets/icons/blooddrop.png'),
                          title: "الضغط",
                          value: "66/123",
                          unit: "mmHg",
                          color: Constants.lightYellow)
                    ],
                  ),
                ),

                // Section Cards - Daily Medication
                SizedBox(height: 50),

                Text(
                  "الطلبات",
                  style: TextStyle(
                    color: Constants.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Container(
                    height: 125,
                    child: ListView.builder(
                      itemCount: widget.req.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return CardSection(
                          image: AssetImage('assets/icons/capsule.png'),
                          title: widget.req[i].title,
                          value: widget.req[i].budget.toString(),
                          unit: "SR",
                          time: "6-7AM",
                          isDone: widget.req[i].status,
                        );
                      },
                    )),

                SizedBox(height: 50),

                // Scheduled Activities
                Text(
                  "احصائيات",
                  style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      CardItems(
                        image: Image.asset(
                          'assets/icons/dental.png',
                        ),
                        title: "علاج اسنان",
                        value: widget.user.dBudget.toString(),
                        unit: "SR",
                        color: (widget.user.dBudget / 2000 * 100).toInt() < 70
                            ? Constants.lightBlue
                            : Colors.red.shade200,
                        progress: (widget.user.dBudget / 2000 * 100).toInt(),
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/eye.png',
                        ),
                        title: "علاج عيون",
                        value: widget.user.eBudget.toString(),
                        unit: "SR",
                        color: ((widget.user.eBudget / 400) * 100).toInt() < 70
                            ? Constants.lightBlue
                            : Colors.red.shade200,
                        progress: (widget.user.eBudget / 400 * 100).toInt(),
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/burth.png',
                        ),
                        title: "حمل وولادة",
                        value: widget.user.bBudget.toString(),
                        unit: "SR",
                        color: (widget.user.bBudget / 15000 * 100).toInt() < 70
                            ? Constants.lightBlue
                            : Colors.red.shade200,
                        progress: (widget.user.bBudget / 15000 * 100).toInt(),
                      ),
                    ],
                  ),
                ),
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
