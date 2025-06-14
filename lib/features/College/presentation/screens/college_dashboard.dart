import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:gradgate/features/Employer/presentation/widgets/count_widget.dart';
import 'package:gradgate/Profile/presentation/screens/view_profile.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'dart:convert';

import 'package:gradgate/shared/widgets/student_college.dart'; // Import to handle JSON parsing

class CollegeDashboard extends StatefulWidget {
  const CollegeDashboard({super.key});

  @override
  State<CollegeDashboard> createState() => _EmpdashboardState();
}

class _EmpdashboardState extends State<CollegeDashboard> {
  late quill.Document aboutDocument;

  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();
  int candidates = 0, hired = 0, activeJobs = 0, avgSalary = 0;
  void fetchStats() async {
    final stats = await DBHelper().getCollegeDashboardData(varName);
    setState(() {
      candidates = stats['applied'];
      hired = stats['hired'];
      activeJobs = stats['active_jobs'];
      avgSalary = (stats['avg_salary']);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStats();
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
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    CountWidget(
                        color: const Color(0xffeaf2fd),
                        count: candidates,
                        title: "New Candidates",
                        icon: Icons.school_outlined,
                        iconColor: const Color(0xff60a3fc)),
                    CountWidget(
                      color: const Color(0xfffaecea),
                      count: hired,
                      title: "Candidates Hired",
                      icon: Icons.people_alt_outlined,
                      iconColor: const Color(0xffeba993),
                    ),
                    CountWidget(
                      color: const Color.fromARGB(255, 200, 222, 217),
                      count: activeJobs,
                      title: "Active Jobs",
                      icon: Icons.work_outline_outlined,
                      iconColor: const Color(0xff446d67),
                    ),
                    CountWidget(
                        color: const Color(0xfff9f4ed),
                        count: avgSalary,
                        title: "Average Salary",
                        icon: Icons.currency_rupee,
                        iconColor: const Color(0xfff29f50)),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                    const Text("Students Placed",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),

                    const SizedBox(
                        height:
                            20), // Adding some space between the text and list

                    // Wrap ListView in Expanded to take the remaining space
                    Expanded(
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: DBHelper()
                            .fetchSelectedStudentsWithCompany(varName),
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
                            List<dynamic> std = snapshot.data!['stdData'];
                            // Build the ListView with dynamic data
                            return ListView.builder(
                              itemCount: std.length,
                              itemBuilder: (BuildContext context, int index) {
                                var stud = std[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          String department =
                                              stud['department'];
                                          if (department == "CSE") {
                                            department =
                                                "Computer Science"; // Set department1 to "CS"
                                          } else if (department == "DS") {
                                            department = "Computer Science DS";
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

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewProfile(
                                                        name: stud['name'],
                                                        userType: "Student",
                                                        imgLink: stud['link'],
                                                        nameOrCompany:
                                                            stud['name'],
                                                        depOrType: department,
                                                        locationOrCollege:
                                                            stud['college'],
                                                        mail: stud['email'],
                                                        phone: stud['phone'],
                                                        about: aboutDocument,
                                                      )));
                                        },
                                        child: StudentCollege(
                                            title: stud['name'],
                                            company: stud['company'])),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            // In case there's no data
                            return const Center(
                                child: Text('No students found.'));
                          }
                        },
                      ),
                    ),
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
