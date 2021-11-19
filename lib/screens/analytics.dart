import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

class analytics extends StatefulWidget {
  const analytics({Key? key}) : super(key: key);

  @override
  _analyticsState createState() => _analyticsState();
}

class _analyticsState extends State<analytics> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Your Analytics: "),
      ),
      body: Center(
          child: Column(
              // main col
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            //children of main col
            Container(
                child: Column(children: [
              Text("data"),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.9,
                  center: Text("90.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              )
            ])),
            Container(
                child: Column(children: [
              Text("data"),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.9,
                  center: Text("90.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.red,
                ),
              )
            ])),
            Container(
                child: Column(children: [
              Text("data"),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.9,
                  center: Text("90.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              )
            ])),
          ])),
    );
  }
}
