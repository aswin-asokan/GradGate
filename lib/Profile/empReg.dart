import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/components/regEmp.dart';

class Empreg extends StatefulWidget {
  const Empreg({super.key});

  @override
  State<Empreg> createState() => _EmpregState();
}

class _EmpregState extends State<Empreg> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Regemp()
          : Row(
              children: [ImageSlider(width: width), const Regemp()],
            ),
    );
  }
}
