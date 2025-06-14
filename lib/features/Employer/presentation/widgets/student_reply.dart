import 'package:flutter/material.dart';

class StudentReply extends StatelessWidget {
  const StudentReply({super.key, required this.reply});
  final String reply;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 249, 187),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.redAccent,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Student Reply: $reply",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
