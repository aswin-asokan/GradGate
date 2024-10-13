import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';

class Jobpost extends StatefulWidget {
  const Jobpost({super.key});

  @override
  State<Jobpost> createState() => _JobpostState();
}

class _JobpostState extends State<Jobpost> {
  TextEditingController jobTitle = TextEditingController();
  TextEditingController jobSalary = TextEditingController();
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
              customTextField("Enter Job Title", "Title", jobTitle,
                  TextInputType.text, null),
              const SizedBox(height: 15),
              multilineText(_controller, "Job Description"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
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
                  ),
                  const VerticalDivider(), // The vertical divider
                  Container(
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        customTextField("Enter Job Salary", "Salary", jobSalary,
                            TextInputType.text, null),
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
                              child: Type(Icons.work_outline, "Full Time",
                                  type == "Full Time"),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  type = "Internship"; // Change the job type
                                });
                              },
                              child: Type(Icons.school, "Internship",
                                  type == "Internship"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                toast(
                                    "Job Posted",
                                    "You have successfully Posted the job",
                                    context);
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
                        SizedBox(
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
