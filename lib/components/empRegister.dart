import 'dart:convert'; // Ensure this import for JSON encoding/decoding

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/imgPicker.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/database/employer.dart';
import 'package:gradgate/variables.dart';

class Empregister extends StatefulWidget {
  const Empregister({super.key});

  @override
  State<Empregister> createState() => _EmpregisterState();
}

class _EmpregisterState extends State<Empregister> {
  QuillController about = QuillController.basic();
  String? jsonAbout;
  String img = "assets/images/no-profile-picture-15258 (1).png";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double w = (width < 800) ? width : width * 0.4;

    return SizedBox(
      width: w,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "GradGate",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Customize Experience",
                    style: GoogleFonts.adamina(fontSize: 35),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Upload your Company logo and a short About",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ProfileImage(
                    width: width,
                    path: img,
                  ),
                  const SizedBox(height: 20),

                  // Quill Editor
                  multilineText(about, "About"),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Convert Quill document to JSON
                          jsonAbout =
                              jsonEncode(about.document.toDelta().toJson());
                        });

                        // Check if image URL is null
                        String imageUrl = urlImg ??
                            "assets/images/no-profile-picture-15258 (1).png";

                        // Insert employer data into the database
                        Employer().insertEmployer(
                            var_mail,
                            var_name,
                            var_type,
                            var_loc,
                            jsonAbout!, // Insert JSON as 'about' description
                            var_phone,
                            imageUrl);

                        toast(
                            "Registration Successful",
                            "You have successfully completed the registration process. Use the credentials to login.",
                            context);
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.black),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))))),
                      child: const Text(
                        "Finish",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}