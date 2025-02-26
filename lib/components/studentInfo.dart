import 'package:flutter/material.dart';
import 'package:gradgate/Employer/EmpWid.dart';

Widget studentInfo() {
  return Container(
    width: double.infinity,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(25),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white),
    child: Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        countWidget(const Color(0xffeaf2fd), 1, "Applied",
            Icons.file_open_outlined, const Color(0xff60a3fc)),
        countWidget(const Color(0xfff9f4ed), 0, "Short Listed",
            Icons.list_alt_outlined, const Color(0xfff29f50)),
        countWidget(
          const Color.fromARGB(255, 200, 222, 217),
          0,
          "Waiting Listed",
          Icons.watch_later_outlined,
          const Color(0xff446d67),
        ),
        countWidget(
          const Color(0xfffaecea),
          0,
          "Rejected",
          Icons.not_interested_outlined,
          const Color(0xffeba993),
        ),
      ],
    ),
  );
}
