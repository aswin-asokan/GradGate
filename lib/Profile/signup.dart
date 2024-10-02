import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
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
              children: [
                Container(
                  height: double.infinity,
                  width: width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        "assets/images/back.jpg",
                        fit: BoxFit
                            .cover, // Ensures the image covers the entire container
                        height: double
                            .infinity, // Makes sure the image takes full height
                        width: double
                            .infinity, // Makes sure the image takes full width
                      ),
                    ),
                  ),
                ),
                const Sign()
              ],
            ),
    );
  }
}
