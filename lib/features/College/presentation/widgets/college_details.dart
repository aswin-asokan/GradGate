import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/location_autocomplete.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class CollegeDetails extends StatefulWidget {
  const CollegeDetails({super.key});

  @override
  State<CollegeDetails> createState() => _CollegeDetailsState();
}

class _CollegeDetailsState extends State<CollegeDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController location =
      TextEditingController(); // Controller for location
  TextEditingController phone = TextEditingController();
  TextEditingController type = TextEditingController();

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

  Future<void> registerCollege(BuildContext context) async {
    try {
      await DBHelper().insertCollege({
        'email': varMail,
        'name': varName,
        'location': varLocation,
        'phone': varPhone,
      });
      // ignore: use_build_context_synchronously
      toast("College Registered", "Success", context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      toast("College Registration Failed", e.toString(), context);
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
                    "Enter your College details to continue",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),

                  CustomTextfield(
                    hint: "Enter College name",
                    head: "College name",
                    controller: name,
                    type: TextInputType.name,
                  ),
                  const SizedBox(height: 20),

                  // Use the LocationAutocomplete widget here
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Location",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LocationAutocomplete(locationController: location),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                      hint: "Enter Phone number",
                      head: "Phone number",
                      controller: phone,
                      type: TextInputType.number,
                      max: 10),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (name.text.isNotEmpty &&
                            location.text.isNotEmpty &&
                            phone.text.isNotEmpty) {
                          setState(() {
                            varLocation = location.text.toString();
                            varName = name.text.toString();
                            varPhone = phone.text.toString();
                          });
                          registerUser(context);
                          registerCollege(context);
                          Navigator.popAndPushNamed(context, '/login');
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
                        "Register",
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
