import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/collSelect.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';

class Studdetails extends StatefulWidget {
  const Studdetails({super.key});

  @override
  State<Studdetails> createState() => _StuddetailsState();
}

class _StuddetailsState extends State<Studdetails> {
  TextEditingController name = TextEditingController();
  TextEditingController location =
      TextEditingController(); // Controller for location
  TextEditingController phone = TextEditingController();
  TextEditingController type = TextEditingController();
  String? selectedDepartment;

  // List of departments

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
                    "Enter your details to continue",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 50),

                  customTextField("Enter your name", "Name", name,
                      TextInputType.name, null),
                  const SizedBox(height: 20),
                  //college select
                  collSelect(colleges),

                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Department",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double
                            .infinity, // Set width to full width of parent
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0), // Optional padding
                        decoration: BoxDecoration(
                          color: textField, // Set grey background color
                          borderRadius: BorderRadius.circular(
                              5.0), // Optional rounded corners
                          border: Border.all(
                              color: textField), // Add border if needed
                        ),
                        child: DropdownButton<String>(
                          value: selectedDepartment,
                          hint: const Text("Choose Department"),
                          isExpanded:
                              true, // Expands the dropdown to full width
                          underline: SizedBox(), // Removes the underline
                          items: departments.map((String department) {
                            return DropdownMenuItem<String>(
                              value: department,
                              child: Text(department),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDepartment = newValue;
                            });
                          },
                          dropdownColor: Colors
                              .grey.shade200, // Optional: Change dropdown color
                        ),
                      ),
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
                      onPressed: () {
                        if (name.text.isNotEmpty &&
                            location.text.isNotEmpty &&
                            phone.text.isNotEmpty &&
                            type.text.isNotEmpty) {
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
