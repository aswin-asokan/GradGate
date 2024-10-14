import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/custPass.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/Controller/logCon.dart';
import 'package:gradgate/database/employer.dart';

import 'package:gradgate/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  if (email.text.isEmpty || pass.text.isEmpty) {
    // Show a toast for empty fields
    toast("Empty fields", "Enter all fields.", context);
    return; // Exit if fields are empty
  }

  // Call verifyUser
  Map<String, dynamic> loginResult = await AuthService().verifyUser(email.text, pass.text);

  if (loginResult['success'] == true) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mail', email.text);

    // Retrieve user type and ID
   String id = loginResult['user_id'];
    String userType = loginResult['user_type'];

    // Store ID and user type in SharedPreferences
    await prefs.setString('userId', id);
    await prefs.setString('userType', userType);
      if (userType == "Student") {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/StudentHome');
      } else if (userType == "College") {
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, '/CollegeHome');
      } else if (userType == "Employer") {
        String mail = "",
            companyName = "",
            industry = "",
            location = "",
            about = "",
            phone = "",
            image = "";
        var doc;
        // ignore: use_build_context_synchronously
       /* List<Map<String, dynamic>> employers =
            await Employer().getEmployers(email.text);

        // Loop through each employer and store the details in variables
        for (var employer in employers) {
          mail = employer['mail'];
          companyName = employer['company_name'];
          industry = employer['industry_type'];
          location = employer['location'];
          about = employer['about'];
          phone = employer['phone'];
          image = employer['image'];
          doc = Document.fromJson(jsonDecode(about));
        }
        setState(() {
          urlImg = image;
          var_loc = location;
          var_name = companyName;
          var_type = industry;
          var_phone = phone;
          var_about = doc;
          var_mail = mail;
        });
        print(urlImg);*/
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
                  customTextField("Enter your email", "Email", email,
                      TextInputType.emailAddress, null),
                  const SizedBox(height: 20),
                  Custpass(
                      head: "Password",
                      hint: "Enter your Password",
                      pass: pass),
                  const SizedBox(height: 10),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: TextButton(
                  //       onPressed: () {},
                  //       child: const Text(
                  //         "Forgot Password?",
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(color: Colors.black),
                  //       )),
                  // ),
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
