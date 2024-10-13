import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';

Widget countWidget(
    Color color, int count, String title, IconData icon, Color iconColor) {
  return Container(
    padding: const EdgeInsets.all(25),
    width: 350,
    height: 160,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: color),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 40,
                )),
          ],
        ),
        const SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
            ),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
          ],
        )
      ],
    ),
  );
}

Widget jobList(String title, String status) {
  Color color;
  if (status == "Active") {
    color = Colors.green;
  } else if (status == "In Progress") {
    color = Colors.blue;
  } else {
    color = Colors.red;
  }
  return Container(
    height: 80,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: secBg),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
