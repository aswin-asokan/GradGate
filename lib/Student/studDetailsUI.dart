import 'package:flutter/material.dart';
import 'package:gradgate/Student/studDetails.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';

class Studdetailsui extends StatefulWidget {
  const Studdetailsui({super.key});

  @override
  State<Studdetailsui> createState() => _StuddetailsuiState();
}

class _StuddetailsuiState extends State<Studdetailsui> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Studdetails()
          : Row(
              children: [ImageSlider(width: width), const Studdetails()],
            ),
    );
  }
}
