import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/image_picker.dart';
import 'package:gradgate/shared/widgets/multi_line_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/shared/widgets/toast.dart';

class Empregister extends StatefulWidget {
  const Empregister({super.key});

  @override
  State<Empregister> createState() => _EmpregisterState();
}

class _EmpregisterState extends State<Empregister> {
  Future<void> registerUser(BuildContext context) async {
    try {
      final db = DBHelper();
      await db.insertUser({
        'email': varMail,
        'password': varPassword,
        'usertype': varType,
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast("User Registration Failed", e.toString(), context);
      rethrow;
    }
  }

  Future<void> registerEmployer(
      BuildContext context, QuillController about) async {
    try {
      final aboutJson = jsonEncode(about.document.toDelta().toJson());

      await DBHelper().insertEmployer({
        'email': varMail,
        'name': varName,
        'location': varLocation,
        'type': compType,
        'phone': varPhone,
        'about': aboutJson,
        'link': urlImg
      });

      // ignore: use_build_context_synchronously
      toast("Employer Registered", "Success", context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast("Employer Registration Failed", e.toString(), context);
      rethrow;
    }
  }

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
                  ImagePicker(
                    width: width,
                    path: img,
                  ),
                  const SizedBox(height: 20),

                  // Quill Editor
                  MultiLineText(controller: about, head: "About"),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        registerUser(context);
                        registerEmployer(context, about);
                        urlImg =
                            "assets/images/no-profile-picture-15258 (1).png";
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
