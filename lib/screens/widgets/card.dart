import 'package:flutter/material.dart';

class card extends StatelessWidget {
  String title;
  String status;
  String hospitalName;
  String companyName;

  card(this.title, this.status, this.hospitalName, this.companyName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                margin: EdgeInsets.only(left: 50, right: 50),
                elevation: 5,
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        "الطلب: " + title,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text("حالة الطلب: " + status,
                          style: TextStyle(fontSize: 12)),
                      Text("أسم المستشفى: " + hospitalName,
                          style: TextStyle(fontSize: 12)),
                      Text("أسم الشركة: " + companyName,
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
