import 'package:flutter/material.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/shared/widgets/location_autocomplete.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class EmployerDetails extends StatefulWidget {
  const EmployerDetails({super.key});

  @override
  State<EmployerDetails> createState() => _EmployerDetailsState();
}

class _EmployerDetailsState extends State<EmployerDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController location =
      TextEditingController(); // Controller for location
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

                  CustomTextfield(
                      hint: "Enter Company name",
                      head: "Company name",
                      controller: name,
                      type: TextInputType.name),
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
                    hint: "Enter Industry Type",
                    head: "Industry Type",
                    controller: type,
                    type: TextInputType.text,
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
                            phone.text.isNotEmpty &&
                            type.text.isNotEmpty) {
                          setState(() {
                            varLocation = location.text.toString();
                            varName = name.text.toString();
                            varPhone = phone.text.toString();
                            compType = type.text.toString();
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
