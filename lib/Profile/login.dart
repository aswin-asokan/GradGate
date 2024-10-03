import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/components/log.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
