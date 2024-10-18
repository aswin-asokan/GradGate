import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';

Widget countWidget(
    Color color, int count, String title, IconData icon, Color iconColor) {
  return Container(
    padding: EdgeInsets.all(25),
    width: 350,
    height: 160,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: color),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(20),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 40,
                )),
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
            ),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
          ],
        )
      ],
    ),
  );
}

Widget jobList(String title, String status) {
  Color color;
  if (status == "Active" || status == "Selected") {
    color = Colors.green;
  } else if (status == "In Progress" || status == "Applied") {
    color = Colors.blue;
  } else if (status == "Closed" || status == "Rejected") {
    color = Colors.red;
  } else {
    color = Colors.orangeAccent;
  }
  return Container(
    height: 80,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: secBg),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          status,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: color),
        )
      ],
    ),
  );
}
