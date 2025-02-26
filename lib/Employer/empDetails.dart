import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';
import 'package:gradgate/Controller/userCont.dart';


class Empdet extends StatefulWidget {
  const Empdet({super.key});

  @override
  State<Empdet> createState() => _EmpdetState();
}

class _EmpdetState extends State<Empdet> {
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController(); // Controller for location
  TextEditingController phone = TextEditingController();
  TextEditingController type = TextEditingController();
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
                    "Enter Details",
                    style: GoogleFonts.adamina(fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your Company details to continue",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),

                  customTextField("Enter Company name", "Company name", name,
                      TextInputType.name, null),
                  const SizedBox(height: 20),

                  // Use the LocationAutocomplete widget here
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LocationAutocomplete(locationController: location),
                    ],
                  ),
                  const SizedBox(height: 20),
                  customTextField("Enter Industry Type", "Industry Type", type,
                      TextInputType.text, null),
                  const SizedBox(height: 20),
                  customTextField("Enter Phone number", "Phone number", phone,
                      TextInputType.number, 10),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50, 
                    child: ElevatedButton(
                      onPressed: () async {
                        if (name.text.isNotEmpty &&
                            location.text.isNotEmpty &&
                            phone.text.isNotEmpty &&
                            type.text.isNotEmpty) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                           String? user_id = prefs.getString('userId') ??'no value';

                          setState(() {
                            var_loc = location.text.toString();
                            var_name = name.text.toString();
                            var_phone = phone.text.toString();
                            var_type = type.text.toString();
                            print(var_name);
                          });
                          
                   
Navigator.popAndPushNamed(
                              context, '/EmployerRegister');

                          
                        } else {
                          toast("Empty Fields", "Please fill all the fields",
                              context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.black),
                        shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Continue",
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
