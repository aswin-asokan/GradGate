import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/custPass.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';
import 'package:gradgate/Controller/logCon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String type = "Student";

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
                  customTextField("Enter your email", "Email", email,
                      TextInputType.emailAddress, null),
                  const SizedBox(height: 20),
                  Custpass(
                      head: "Password",
                      hint: "Enter your Password",
                      pass: pass),
                  const SizedBox(height: 20),
                  Custpass(
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
                        child: Type(Icons.book, "Student", type == "Student"),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            type = "College";
                          });
                        },
                        child: Type(Icons.school, "College", type == "College"),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            type = "Employer";
                          });
                        },
                        child: Type(
                            Icons.computer, "Employer", type == "Employer"),
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
                          String passwordValue = pass.text.trim();
                          String userTypeValue =
                              type; // Assuming you have user type
                          setState(() {
                            var_mail = emailValue.toString();
                            var_type = userTypeValue;
                          });
                          // Check if the email already exists

                          Map<String, dynamic> loginResult =
                              await AuthService().verifyUser(pass.text);

                          bool exists = loginResult['success'];
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
                          } /*else if (strength ==
                              PasswordStrength.alreadyExposed) {
                            toast(
                                "Password not Secured",
                                "The Passwords you have entered is already exposed",
                                // ignore: use_build_context_synchronously
                                context);
                          } else if (strength == PasswordStrength.weak) {
                            toast(
                                "Password not Secured",
                                "The Passwords you have entered is weak. Try a new password.",
                                // ignore: use_build_context_synchronously
                                context);
                          }*/
                          else {
                            if (exists) {
                              // Show a message indicating that the email is already taken
                              toast(
                                  'Email already exists',
                                  "The email you entered already exists. Try another one!",
                                  // ignore: use_build_context_synchronously
                                  context);
                            } else {
                              // Proceed to insert the new user

                              Map<String, dynamic> signupResult =
                                  await AuthService().signUp(passwordValue);
                              if (signupResult['success'] == true) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                // Retrieve user type and ID
                                String id = signupResult['user_id'];
                                String userType = signupResult['user_type'];
                                setState(() {
                                  StAccess = userType;
                                });
                                // Store ID and user type in SharedPreferences
                                await prefs.setString('userId', id);
                                await prefs.setString('userType', userType);
                                // Show a success message or navigate to another page
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
