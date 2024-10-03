import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/components/sign.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
