import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/Employer/empDetails.dart';
import 'package:gradgate/components/imageSlide.dart';

class EmpDetailsUI extends StatefulWidget {
  const EmpDetailsUI({super.key});

  @override
  State<EmpDetailsUI> createState() => _EmpDetailsUIState();
}

class _EmpDetailsUIState extends State<EmpDetailsUI> {
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
