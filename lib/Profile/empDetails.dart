import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/empDet.dart';
import 'package:gradgate/components/imageSlide.dart';

class Empdetails extends StatefulWidget {
  const Empdetails({super.key});

  @override
  State<Empdetails> createState() => _EmpdetailsState();
}

class _EmpdetailsState extends State<Empdetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Empdet()
          : Row(
              children: [ImageSlider(width: width), const Empdet()],
            ),
    );
  }
}
