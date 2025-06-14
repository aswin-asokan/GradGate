import 'package:flutter/material.dart';

class JobStatus extends StatelessWidget {
  const JobStatus({super.key, required this.head, required this.value});
  final String head;
  final String value;

  Color get color {
    if (value == "Active" || value == "Selected") {
      return Colors.green;
    } else if (value == "In Progress" || value == "Applied") {
      return Colors.blue;
    } else if (value == "Closed" || value == "Rejected") {
      return Colors.red;
    } else if (value == "Waitlist" || value == "Shortlist") {
      return Colors.orangeAccent;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          head,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 25, color: color),
        ),
      ],
    );
  }
}
