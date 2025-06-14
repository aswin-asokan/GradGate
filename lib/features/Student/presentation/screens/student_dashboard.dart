// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/features/Employer/presentation/widgets/job_list.dart';
import 'package:gradgate/features/Student/presentation/widgets/student_info.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/toast.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late Future<Map<String, dynamic>> futureJobList;
  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              const Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 35,
              ),
              const StudentInfo(),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 550, // Outer container height
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Job Status",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),

                    const SizedBox(
                        height:
                            20), // Adding some space between the text and list

                    // Wrap ListView in Expanded to take the remaining space
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future:
                            DBHelper().getJobsAppliedByCurrentStudent(userID),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Error: \${snapshot.error}'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            List<Map<String, dynamic>> jobs = snapshot.data!;

                            return ListView.builder(
                              itemCount: jobs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var job = jobs[index];

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: const Text(
                                                'Job Details',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Job Title: ${job['title'] ?? 'Untitled'}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    'Application Status: ${job['status'] ?? 'Untitled'}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    "Your Reply: ${job['reply'] ?? 'Untitled'}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  if (job['application_status'] ==
                                                          'selected' &&
                                                      job['reply'] == 'waiting')
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          child: ElevatedButton(
                                                            style: const ButtonStyle(
                                                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadiusGeometry.all(Radius.circular(
                                                                            8)))),
                                                                backgroundColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .black87)),
                                                            onPressed:
                                                                () async {
                                                              bool
                                                                  alreadyAccepted =
                                                                  await DBHelper()
                                                                      .hasAcceptedOffer(
                                                                          userID);

                                                              if (alreadyAccepted) {
                                                                toast(
                                                                    "Application Blocked",
                                                                    "You have already accepted another offer.",
                                                                    context);
                                                                return;
                                                              }
                                                              await DBHelper()
                                                                  .updateStudentReply(
                                                                      job['job_id'],
                                                                      'accepted',
                                                                      userID);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              toast(
                                                                  "Accepted",
                                                                  "You have accepted the offer.",
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              'Accept Offer',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 50,
                                                          child: ElevatedButton(
                                                            style: const ButtonStyle(
                                                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadiusGeometry.all(Radius.circular(
                                                                            8)))),
                                                                backgroundColor:
                                                                    WidgetStatePropertyAll(
                                                                        Colors
                                                                            .redAccent)),
                                                            onPressed:
                                                                () async {
                                                              await DBHelper()
                                                                  .updateStudentReply(
                                                                      job['job_id'],
                                                                      'rejected',
                                                                      userID);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              toast(
                                                                  "Rejected",
                                                                  "You have rejected the offer.",
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              'Reject Offer',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  else if (job[
                                                          'application_status'] ==
                                                      'selected')
                                                    Text(
                                                        "You have already responded: ${job['reply']}"),
                                                  if (job['application_status'] !=
                                                      'selected')
                                                    const Text(
                                                        'You are not selected for this position yet.'),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Close',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: JobList(
                                        title: job['title'],
                                        status: job['status'],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text('No jobs found.'));
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
