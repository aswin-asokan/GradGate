import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/widgets/multi_line_text.dart';
import 'package:gradgate/shared/widgets/type_widget.dart';
import 'package:intl/intl.dart';

class JobPost extends StatefulWidget {
  const JobPost({super.key});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  final TextEditingController _dateController = TextEditingController();
  QuillController desc = QuillController.basic();

  // Function to show date picker and update the TextField
  Future<void> _selectDate(BuildContext context) async {
    // Initial date is today, but you can customize it
    DateTime selectedDate = DateTime.now();

    // Show the date picker
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Current date as default
      firstDate: DateTime(2000), // Earliest date the user can select
      lastDate: DateTime(2100), // Latest date the user can select
    );

    if (picked != null && picked != selectedDate) {
      // If a date is selected, format it and update the TextField
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController jobTitle = TextEditingController();
  TextEditingController jobSalary = TextEditingController();
  TextEditingController last = TextEditingController();
  final QuillController _controller = QuillController.basic();
  String type = "Full Time"; // State for job type selection
  bool isCS = false;
  bool isAIML = false;
  bool isCSDS = false;
  bool isMechanical = false;
  bool isCivil = false;
  bool isElectronics = false;
  bool isEEE = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Post A Job",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              CustomTextfield(
                hint: "Enter Job Title",
                head: "Title",
                controller: jobTitle,
                type: TextInputType.text,
              ),
              const SizedBox(height: 15),
              MultiLineText(controller: _controller, head: "Job Description"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Branches",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        CheckboxListTile(
                          title: const Text("Computer Science"),
                          value: isCS,
                          onChanged: (value) {
                            setState(() {
                              isCS = value!;
                            });
                          },
                        ),
                        // Checkbox for AIML
                        CheckboxListTile(
                          title: const Text("AIML"),
                          value: isAIML,
                          onChanged: (value) {
                            setState(() {
                              isAIML = value!;
                            });
                          },
                        ),
                        // Checkbox for Computer Science DS
                        CheckboxListTile(
                          title: const Text("Computer Science DS"),
                          value: isCSDS,
                          onChanged: (value) {
                            setState(() {
                              isCSDS = value!;
                            });
                          },
                        ),
                        // Checkbox for Mechanical
                        CheckboxListTile(
                          title: const Text("Mechanical"),
                          value: isMechanical,
                          onChanged: (value) {
                            setState(() {
                              isMechanical = value!;
                            });
                          },
                        ),
                        // Checkbox for Civil
                        CheckboxListTile(
                          title: const Text("Civil"),
                          value: isCivil,
                          onChanged: (value) {
                            setState(() {
                              isCivil = value!;
                            });
                          },
                        ),
                        // Checkbox for Electronics
                        CheckboxListTile(
                          title: const Text("Electronics"),
                          value: isElectronics,
                          onChanged: (value) {
                            setState(() {
                              isElectronics = value!;
                            });
                          },
                        ),
                        // Checkbox for EEE
                        CheckboxListTile(
                          title: const Text("EEE"),
                          value: isEEE,
                          onChanged: (value) {
                            setState(() {
                              isEEE = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(), // The vertical divider
                  SizedBox(
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextfield(
                          hint: "Enter Job Salary",
                          head: "Salary",
                          controller: jobSalary,
                          type: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "End Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller:
                                  _dateController, // Connect the controller
                              decoration: InputDecoration(
                                hintText: "select a Date",
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
                              // Disable typing and open the date picker on tap
                              readOnly: true,
                              onTap: () => _selectDate(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Job Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  type = "Full Time"; // Change the job type
                                });
                              },
                              child: TypeWidget(
                                  icon: Icons.work_outline,
                                  text: "Full Time",
                                  isSelected: type == "Full Time"),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  type = "Internship"; // Change the job type
                                });
                              },
                              child: TypeWidget(
                                  icon: Icons.school,
                                  text: "Internship",
                                  isSelected: type == "Internship"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                List<String> selectedBranches = [];
                                // Check which checkboxes are selected and add the branch name to the list
                                if (isCS) selectedBranches.add("CSE");
                                if (isAIML) selectedBranches.add("AIML");
                                if (isCSDS) selectedBranches.add("DS");
                                if (isMechanical) selectedBranches.add("ME");
                                if (isCivil) selectedBranches.add("CE");
                                if (isElectronics) selectedBranches.add("EC");
                                if (isEEE) selectedBranches.add("EEE");
                                String branchString =
                                    selectedBranches.join(','); // "CSE,AIML,DS"

                                final employerId = await DBHelper()
                                    .getEmployerIdByEmail(varMail);

                                if (employerId != null) {
                                  await DBHelper().insertJob({
                                    'employer_id': employerId,
                                    'title': jobTitle.text.toString(),
                                    'status': 'active',
                                    'description': jsonEncode(_controller
                                        .document
                                        .toDelta()
                                        .toJson()),
                                    'branches': branchString,
                                    'salary': jobSalary.text.toString(),
                                    'date': _dateController.text.toString(),
                                    'type': type,
                                  });
                                }
                                resetValues();
                              },
                              style: ButtonStyle(
                                  backgroundColor: const WidgetStatePropertyAll(
                                      Colors.black),
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))))),
                              child: const Text(
                                "Post Job",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                resetValues();
                              },
                              style: ButtonStyle(
                                  backgroundColor: const WidgetStatePropertyAll(
                                      Color.fromARGB(255, 187, 210, 250)),
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))))),
                              child: const Text(
                                "Reset Values",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      ],
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

  void resetValues() {
    setState(() {
      jobTitle.clear();
      jobSalary.clear();
      _controller.clear();
      isCS = false;
      isAIML = false;
      isCSDS = false;
      isMechanical = false;
      isCivil = false;
      isElectronics = false;
      isEEE = false;
      type == "Full Time";
    });
  }
}
