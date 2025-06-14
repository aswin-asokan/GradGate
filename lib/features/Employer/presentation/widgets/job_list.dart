import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

class JobList extends StatelessWidget {
  const JobList({super.key, required this.title, required this.status});
  final String title;
  final String status;

  Color get color {
    if (status == "sctive" || status == "selected") {
      return Colors.green;
    } else if (status == "in progress" || status == "applied") {
      return Colors.blue;
    } else if (status == "closed" || status == "rejected") {
      return Colors.red;
    } else {
      return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
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
}
