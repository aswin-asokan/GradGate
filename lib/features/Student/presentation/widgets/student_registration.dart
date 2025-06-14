import 'dart:convert'; // Ensure this import for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/shared/widgets/image_picker.dart';
import 'package:gradgate/shared/widgets/multi_line_text.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

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

Future<void> insertStudent({
  required String email,
  required String name,
  required String college,
  required String department,
  required String phone,
  required quill.Document aboutDoc,
}) async {
  final db = await DBHelper().database;
  final student = {
    'email': email,
    'name': name,
    'college': college,
    'department': department,
    'phone': phone,
    'about': jsonEncode(aboutDoc.toDelta().toJson()),
    'link': urlImg
  };

  await db.insert(
    'students',
    student,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> registerStudent(
    BuildContext context, QuillController about) async {
  try {
    await insertStudent(
      email: varMail,
      name: varName,
      college: varCollege,
      department: stuDepartment!,
      phone: varPhone,
      aboutDoc: about.document,
    );
  } catch (e) {
    // ignore: use_build_context_synchronously
    toast("Student Profile Failed", e.toString(), context);
    rethrow;
  }
}

Future<void> handleStudentRegistration(
    BuildContext context, QuillController about) async {
  try {
    await registerUser(context);
    // ignore: use_build_context_synchronously
    await registerStudent(context, about);

    toast(
      "Registration Successful",
      "You have successfully completed the registration process. Use the credentials to login.",
      // ignore: use_build_context_synchronously
      context,
    );
    urlImg = "assets/images/no-profile-picture-15258 (1).png";
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, '/login');
  } catch (e) {
    toast(
      "Error",
      e.toString(),
      // ignore: use_build_context_synchronously
      context,
    );
  }
}

class _StudentRegistrationState extends State<StudentRegistration> {
  QuillController about = QuillController.basic();
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
                    "Upload your photo and a short About",
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
                      onPressed: () async {
                        await handleStudentRegistration(context, about);
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
