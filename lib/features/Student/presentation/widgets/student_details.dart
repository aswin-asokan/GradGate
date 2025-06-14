import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/features/Student/presentation/widgets/student_department.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController college = TextEditingController();
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
                  CustomTextfield(
                    head: "Enter your name",
                    hint: "Name",
                    controller: name,
                    type: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "College",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<String>>(
                        future: DBHelper().fetchCollegeNames(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // or SizedBox(height: 50)
                          } else if (snapshot.hasError) {
                            return const Text("Error loading colleges");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No colleges found");
                          }

                          List<String> collegeNames = snapshot.data!;
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: "Choose college",
                              hintStyle: const TextStyle(
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
                            value:
                                college.text.isNotEmpty ? college.text : null,
                            items: collegeNames.map((String name) {
                              return DropdownMenuItem<String>(
                                value: name,
                                child: Text(name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                college.text = value;
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const StudentDepartment(),
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
                        if (name.text.isNotEmpty && phone.text.isNotEmpty) {
                          setState(() {
                            varName = name.text.toString();
                            varPhone = phone.text.toString();
                            varCollege = college.text.toString();
                          });
                          Navigator.popAndPushNamed(
                              context, '/StudentRegister');
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
