import 'package:flutter/material.dart';
import 'package:aamen/screens/widgets/infoCard.dart';
class generalInfo extends StatefulWidget {
  const generalInfo({Key? key}) : super(key: key);

  @override
  _generalInfoState createState() => _generalInfoState();
}

class _generalInfoState extends State<generalInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Information"),
        ),
        body: Center(
            child: Column(
          children: [infoCard("user name"),infoCard("user email"),infoCard("user bla bla bla")],
        )),
      ),
    );
  }
}
