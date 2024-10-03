import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imgPicker.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/database/employer.dart';
import 'package:gradgate/variables.dart';

class Regemp extends StatefulWidget {
  const Regemp({super.key});

  @override
  State<Regemp> createState() => _RegempState();
}

class _RegempState extends State<Regemp> {
  TextEditingController about = new TextEditingController();
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
                    style: GoogleFonts.adamina(fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Upload your Company logo and a short About",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  ProfileImage(
                    width: width,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: about,
                        maxLines: 8,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: "Enter a short about",
                          hintStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          counterText: "",
                          fillColor: textField,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textField),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textField),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: textField),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (about.text.isEmpty) {
                            toast(
                                "Give an About",
                                "Please provide a simple introduction of your company",
                                context);
                          } else {
                            setState(() {
                              cabout = about.text.toString();
                            });
                            if (urlImg == null) {
                              String asset =
                                  "assets/images/no-profile-picture-15258 (1).png";
                              Employer().insertEmployer(mailID, cname,
                                  industryType, loc, cabout, cphone, asset);
                            } else {
                              Employer().insertEmployer(mailID, cname,
                                  industryType, loc, cabout, cphone, urlImg!);
                            }
                            toast(
                                "Registration Successful",
                                "You have successfully completed the registration process. Use the credentials to login.",
                                context);
                            Navigator.popAndPushNamed(context, '/login');
                          }
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
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
