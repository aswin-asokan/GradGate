import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/custPass.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/database/loginData.dart';

class Log extends StatefulWidget {
  const Log({super.key});

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  // Function to handle user login
  Future<void> _handleLogin() async {
    // Validate input fields

    // Verify user credentials
    bool isValidUser = await Logindata().verifyUser(email.text, pass.text);
    if (email.text.isEmpty || pass.text.isEmpty) {
      // ignore: use_build_context_synchronously
      toast("Empty fields", "Enter all fields.", context);
    } else if (isValidUser) {
      String? usertype = await Logindata().getUserType(email.text, pass.text);
      if (usertype == "Student") {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/StudentHome');
      } else if (usertype == "College") {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/CollegeHome');
      } else if (usertype == "Employer") {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/EmployerHome');
      }
    } else {
      toast(
          "Login Error",
          // ignore: use_build_context_synchronously
          "The Mail id or Password provided is incorrect. Try again.",
          context);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                customTextField("Enter your email", "Email", email,
                    TextInputType.emailAddress, null),
                const SizedBox(height: 20),
                Custpass(
                    head: "Password", hint: "Enter your Password", pass: pass),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
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
    );
  }
}
