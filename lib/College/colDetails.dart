import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradgate/Controller/collCon.dart';



class Coldetails extends StatefulWidget {
  const Coldetails({super.key});

  @override
  State<Coldetails> createState() => _ColdetailsState();
}

class _ColdetailsState extends State<Coldetails> {
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
                    "Enter your College details to continue",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),

                  customTextField("Enter College name", "College name", name,
                      TextInputType.name, null),
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
                  customTextField("Enter Phone number", "Phone number", phone,
                      TextInputType.number, 10),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ()async {
                        if (name.text.isNotEmpty &&
                            location.text.isNotEmpty &&
                            phone.text.isNotEmpty) {
                          setState(() {
                            var_loc = location.text.toString();
                            var_name = name.text.toString();
                            var_phone = phone.text.toString();
                            print(var_name); 
                          });
                          
        Map<String, dynamic>  addResult = await collCont().addColl();
                     
          if(addResult['success'])
        {
                        toast(
                            "Registration Successful",
                            "You have successfully completed the registration process. Use the credentials to login.",
                            context);
                        Navigator.popAndPushNamed(context, '/login');
        }
                              
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
