import 'package:flutter/material.dart';

class infoCard extends StatelessWidget {
  String text;
  infoCard(this.text);



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          Icons.analytics,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 20.0,
              color: Colors.teal.shade900),
        ),
      ),
    );
  }
}
