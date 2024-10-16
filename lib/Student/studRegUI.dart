import 'package:flutter/material.dart';
import 'package:gradgate/Student/studReg.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';

class Studregui extends StatefulWidget {
  const Studregui({super.key});

  @override
  State<Studregui> createState() => _StudreguiState();
}

class _StudreguiState extends State<Studregui> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Studreg()
          : Row(
              children: [ImageSlider(width: width), const Studreg()],
            ),
    );
  }
}
