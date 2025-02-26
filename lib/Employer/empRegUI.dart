import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';
import 'package:gradgate/Employer/empRegister.dart';

class Empregui extends StatefulWidget {
  const Empregui({super.key});

  @override
  State<Empregui> createState() => _EmpreguiState();
}

class _EmpreguiState extends State<Empregui> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Empregister()
          : Row(
              children: [ImageSlider(width: width), const Empregister()],
            ),
    );
  }
}
