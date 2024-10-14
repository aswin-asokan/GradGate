import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/components/login.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Log()
          : Row(
              children: [ImageSlider(width: width), const Log()],
            ),
    );
  }
}
