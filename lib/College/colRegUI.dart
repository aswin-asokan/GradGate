import 'package:flutter/material.dart';
import 'package:gradgate/College/colDetails.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imageSlide.dart';

class ColregUI extends StatefulWidget {
  const ColregUI({super.key});

  @override
  State<ColregUI> createState() => _ColregUIState();
}

class _ColregUIState extends State<ColregUI> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Coldetails()
          : Row(
              children: [ImageSlider(width: width), const Coldetails()],
            ),
    );
  }
}
