import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/shared/widgets/custom_password.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/shared/widgets/type_widget.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String type = "Student";
  Future<bool> isEmailExists(String email) async {
    final db = await DBHelper().database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double w = (width < 800) ? width : width * 0.4;

    return SingleChildScrollView(
      child: SizedBox(
        width: w,
        child: Padding(
          padding: const EdgeInsets.all(30),
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
                  const SizedBox(height: 30),
                  Text(
                    "Register Now",
                    style: GoogleFonts.adamina(fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "Enter your email and password to create your account",
                      textAlign: TextAlign.center),
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
                  CustomPassword(
                      head: "Confirm Password",
                      hint: "Confirm your Password",
                      pass: confirm),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Choose User Type",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            type = "Student";
                          });
                        },
                        child: TypeWidget(
                            icon: Icons.book,
                            text: "Student",
                            isSelected: type == "Student"),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            type = "College";
                          });
                        },
                        child: TypeWidget(
                            icon: Icons.school,
                            text: "College",
                            isSelected: type == "College"),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            type = "Employer";
                          });
                        },
                        child: TypeWidget(
                            icon: Icons.computer,
                            text: "Employer",
                            isSelected: type == "Employer"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          String emailValue = email.text.trim().toLowerCase();
                          //String passwordValue = pass.text.trim();
                          String userTypeValue =
                              type; // Assuming you have user type
                          setState(() {
                            varMail = emailValue.toString();
                            varType = userTypeValue;
                          });
                          bool mailvalid =
                              EmailValidatorFlutter().validateEmail(emailValue);
                          if (!mailvalid) {
                            toast(
                                "Invalid mail ID",
                                "The email you have entered is not valid. Try again.",
                                // ignore: use_build_context_synchronously
                                context);
                          } else if (pass.text.trim().toString() !=
                              confirm.text.trim().toString()) {
                            toast(
                                "Password mismatch",
                                "The Passwords you have entered does not match. Try again.",
                                // ignore: use_build_context_synchronously
                                context);
                          } else {
                            bool emailExists = await isEmailExists(emailValue);
                            if (emailExists) {
                              // Show a message indicating that the email is already taken
                              toast(
                                  'Email already exists',
                                  "The email you entered already exists. Try another one!",
                                  // ignore: use_build_context_synchronously
                                  context);
                            } else {
                              setState(() {
                                varPassword = pass.text.toString();
                              });
                              if (userTypeValue == "Student") {
                                Navigator.popAndPushNamed(
                                    context, '/StudentDetails');
                              } else if (userTypeValue == "Employer") {
                                Navigator.popAndPushNamed(
                                    context, '/EmployerDetails');
                              } else {
                                Navigator.popAndPushNamed(
                                    context, '/CollegeRegister');
                              }
                            }
                          }
                        }, // Call the sign-up handler
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.black),
                            shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/login');
                        },
                        style: ButtonStyle(
                            backgroundColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 187, 210, 250)),
                            shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
