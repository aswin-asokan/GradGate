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
  QuillController _controller = QuillController.basic();
  String type = "Full Time"; // State for job type selection

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
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
              Wrap(
                  spacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    SalaryFilter(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Job Type",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = "Full Time"; // Change the job type
                            });
                          },
                          child: Type(Icons.work_outline, "Full Time",
                              type == "Full Time"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = "Internship"; // Change the job type
                            });
                          },
                          child: Type(
                              Icons.school, "Internship", type == "Internship"),
                        ),
                      ],
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
