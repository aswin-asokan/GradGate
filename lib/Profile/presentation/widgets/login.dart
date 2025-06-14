import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/features/College/presentation/screens/college_home.dart';
import 'package:gradgate/features/Employer/presentation/screens/employer_home.dart';
import 'package:gradgate/features/Student/presentation/screens/student_home.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_password.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    final db = await DBHelper().database;

    try {
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isEmpty) {
        // ignore: use_build_context_synchronously
        toast("Login Failed", "Invalid email or password", context);
        return;
      }

      final user = result.first;
      userType = user['usertype'];
      stAccess = userType;
      switch (userType) {
        case 'Student':
          final stud = await db.query(
            'students',
            where: 'email = ?',
            whereArgs: [email],
          );
          if (stud.isNotEmpty) {
            String getFullDepartmentName(String shortCode) {
              switch (shortCode) {
                case 'Computer Science':
                  return 'CSE';
                case 'AIML':
                  return 'AIML';
                case 'Computer Science DS':
                  return 'DS';
                case 'Mechanical':
                  return 'ME';
                case 'Civil':
                  return 'CE';
                case 'Electronics':
                  return 'EC';
                case 'EEE':
                  return 'EEE';
                default:
                  return 'Unknown Department';
              }
            }

            final students = stud.first;
            userID = (students['id'] ?? '') as int;
            varMail = (students['email'] ?? '') as String;
            varName = (students['name'] ?? '') as String;
            varCollege = (students['college'] ?? '') as String;
            stuDepartment = (students['department'] ?? '') as String;
            department = getFullDepartmentName(stuDepartment!);
            varPhone = (students['phone'] ?? '') as String;
            urlImg = (students['link'] ?? '') as String;
            final aboutJson = (students['about'] ?? '') as String;
            if (aboutJson.isNotEmpty) {
              final delta = Delta.fromJson(jsonDecode(aboutJson));
              varAboutJS = Document.fromDelta(delta);
            } else {
              varAboutJS = Document();
            }
          }
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const StudentHome()),
          );
          break;
        case 'College':
          final coll = await db.query(
            'colleges',
            where: 'email = ?',
            whereArgs: [email],
          );
          if (coll.isNotEmpty) {
            final college = coll.first;
            userID = (college['id'] ?? '') as int;
            varMail = (college['email'] ?? '') as String;
            varName = (college['name'] ?? '') as String;
            varLocation = (college['location'] ?? '') as String;
            varPhone = (college['phone'] ?? '') as String;
          }
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const CollegeHome()),
          );
          break;
        case 'Employer':
        default:
          final emp = await db.query(
            'employers',
            where: 'email = ?',
            whereArgs: [email],
          );
          if (emp.isNotEmpty) {
            final employer = emp.first;
            userID = (employer['id'] ?? '') as int;
            varMail = (employer['email'] ?? '') as String;
            varName = (employer['name'] ?? '') as String;
            varLocation = (employer['location'] ?? '') as String;
            varPhone = (employer['phone'] ?? '') as String;
            varType = (employer['type'] ?? '') as String;
            urlImg = (employer['link'] ?? '') as String;
            final aboutJson = (employer['about'] ?? '') as String;
            if (aboutJson.isNotEmpty) {
              final delta = Delta.fromJson(jsonDecode(aboutJson));
              varAboutJS = Document.fromDelta(delta);
            } else {
              varAboutJS = Document();
            }
          }
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const EmployerHome()),
          );
      }

      // ignore: use_build_context_synchronously
      toast("Login Successful", "Welcome back!", context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast("Login Error", e.toString(), context);
      rethrow;
    }
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "GradGate",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back",
                    style: GoogleFonts.adamina(fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your email and password to access your account",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  CustomTextfield(
                    hint: "Enter your email",
                    head: "Email",
                    controller: email,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomPassword(
                      head: "Password",
                      hint: "Enter your Password",
                      pass: pass),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            varMail = email.text.toString();
                          });
                          loginUser(context, email.text.toString(),
                              pass.text.toString());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.black),
                            shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an account "),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
