import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/components/signUP.dart';

class Signupui extends StatefulWidget {
  const Signupui({super.key});

  @override
  State<Signupui> createState() => _SignupuiState();
}

class _SignupuiState extends State<Signupui> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Sign()
          : Row(
              children: [ImageSlider(width: width), const Sign()],
            ),
    );
  }
}
