import 'package:flutter/material.dart';
import 'package:gradgate/features/Employer/presentation/widgets/job_status.dart';
import 'package:gradgate/Profile/presentation/screens/view_profile.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/features/Employer/presentation/widgets/student_reply.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert'; // Import to handle JSON parsing

// ignore: must_be_immutable
class Jobdetails extends StatefulWidget {
  final String title;
  final String salary;
  final String jobType;
  final String status;
  final String about;
  final int result;
  final String jobId;

  const Jobdetails(
      {super.key,
      required this.title,
      required this.jobType,
      required this.result,
      required this.status,
      required this.salary,
      required this.about,
      required this.jobId});

  @override
  State<Jobdetails> createState() => _JobdetailsState();
}

Color color = Colors.black;

class _JobdetailsState extends State<Jobdetails> {
  late Future<List<Map<String, dynamic>>> studentList;

  late quill.Document aboutDocument;

  @override
  void initState() {
    super.initState();
    fetchStudentList();
  }

  void fetchStudentList() async {
    studentList = DBHelper().getStudentsForJob(int.parse(widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secBg,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 5,
              ),
              JobStatus(head: "Status :", value: widget.status),
              JobStatus(head: "Type    :", value: widget.jobType),
              JobStatus(head: "Salary :", value: widget.salary.toString()),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 600, // Outer container height
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Applicants",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),
                    const SizedBox(
                        height:
                            20), // Adding some space between the text and list
                    // Wrap ListView in Expanded to take the remaining space
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: studentList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting for the data, show a loading indicator
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // If there's an error, display an error message
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            // Assuming 'jobs' is a list in the response data
                            List<Map<String, dynamic>> students =
                                snapshot.data!;
                            // Build the ListView with dynamic data
                            return ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (BuildContext context, int index) {
                                var stud = students[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        bool alreadyAccepted = await DBHelper()
                                            .hasAcceptedOtherOffer(
                                                studentId: stud['students_id'],
                                                currentJobId:
                                                    int.parse(widget.jobId));
                                        if (stud['reply'] != 'accepted' &&
                                            !alreadyAccepted) {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                            ),
                                            builder: (context) {
                                              String department =
                                                  stud['department'];
                                              if (department == "CSE") {
                                                department = "Computer Science";
                                              } else if (department == "DS") {
                                                department =
                                                    "Computer Science DS";
                                              } else if (department == "ME") {
                                                department = "Mechanical";
                                              } else if (department == "CE") {
                                                department = "Civil";
                                              } else if (department == "EC") {
                                                department = "Electronics";
                                              }

                                              final List<dynamic> aboutJson =
                                                  jsonDecode(stud['about']);
                                              aboutDocument =
                                                  quill.Document.fromJson(
                                                      aboutJson);

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                stud['link']),
                                                      ),
                                                      title: Text(stud['name'],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      subtitle: Text(
                                                          "$department - ${stud['college']}"),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ViewProfile(
                                                              name:
                                                                  stud['name'],
                                                              userType:
                                                                  "Student",
                                                              imgLink:
                                                                  stud['link'],
                                                              nameOrCompany:
                                                                  stud['name'],
                                                              depOrType:
                                                                  department,
                                                              locationOrCollege:
                                                                  stud[
                                                                      'college'],
                                                              mail:
                                                                  stud['email'],
                                                              phone:
                                                                  stud['phone'],
                                                              about:
                                                                  aboutDocument,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                          onPressed: () async {
                                                            await DBHelper()
                                                                .updateStudentApplicationStatus(
                                                              jobId: int.parse(
                                                                  widget.jobId),
                                                              studentId:
                                                                  stud['id'],
                                                              newStatus:
                                                                  'selected',
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            setState(
                                                                () {}); // Refresh UI
                                                            toast(
                                                                "Student Selected",
                                                                "${stud['name']} has been selected.",
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.check),
                                                          label: const Text(
                                                              "Select"),
                                                        ),
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.orange,
                                                          ),
                                                          onPressed: () async {
                                                            await DBHelper()
                                                                .updateStudentApplicationStatus(
                                                              jobId: int.parse(
                                                                  widget.jobId),
                                                              studentId:
                                                                  stud['id'],
                                                              newStatus:
                                                                  'waiting',
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                            toast(
                                                                "Waitlisted",
                                                                "${stud['name']} is waitlisted.",
                                                                context);
                                                          },
                                                          icon: const Icon(Icons
                                                              .hourglass_empty),
                                                          label: const Text(
                                                              "Waitlist"),
                                                        ),
                                                        ElevatedButton.icon(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                          onPressed: () async {
                                                            await DBHelper()
                                                                .updateStudentApplicationStatus(
                                                              jobId: int.parse(
                                                                  widget.jobId),
                                                              studentId:
                                                                  stud['id'],
                                                              newStatus:
                                                                  'rejected',
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                            toast(
                                                                "Rejected",
                                                                "${stud['name']} has been rejected.",
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.close),
                                                          label: const Text(
                                                              "Reject"),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else if (stud['reply'] ==
                                            'accepted') {
                                          toast(
                                              "Unsuccessful",
                                              "This student is already selected",
                                              context);
                                        } else {
                                          toast(
                                              "Unsuccessful",
                                              "This student already joined another company",
                                              context);
                                        }
                                      },
                                      child: Container(
                                        height: 90,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color:
                                                secBg // Change to your secBg color
                                            ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              stud['name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            if (stud['application_status'] ==
                                                "selected")
                                              StudentReply(reply: stud['reply'])
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            // In case there's no data
                            return const Center(child: Text('No jobs found.'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 25,
                runSpacing: 25,
                children: [
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.redAccent),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))))),
                      onPressed: () async {
                        await DBHelper()
                            .updateJobStatusToClosed(int.parse(widget.jobId));
                        toast(
                          "Status Changed",
                          "The job status has been updated to closed.",
                          context,
                        );
                        setState(() {}); // refresh the UI if needed
                      },
                      child: const Text("Change Status to Closed",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.blueAccent),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))))),
                      onPressed: () async {
                        await DBHelper().updateJobStatus(
                            int.parse(widget.jobId), 'in progress');
                        toast(
                          "Status Changed",
                          "The job status has been updated to in progress.",
                          context,
                        );
                        setState(() {}); // Optional: refresh the UI
                      },
                      child: const Text("Change Status to In Progress",
                          style: TextStyle(color: Colors.white)),
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
