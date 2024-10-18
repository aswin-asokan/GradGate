import 'package:flutter/material.dart';
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/Employer/jobDetails.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/Controller/userCont.dart';

class Empdashboard extends StatefulWidget {
  const Empdashboard({super.key});

  @override
  State<Empdashboard> createState() => _EmpdashboardState();
}

class _EmpdashboardState extends State<Empdashboard> {
  late Future<Map<String, dynamic>> futureJobList;

  @override
  void initState() {
    super.initState();
    futureJobList = Usercont().jobList(); // Call the jobList function from the controller
  }

  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();

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
                    countWidget(const Color(0xffeaf2fd), 700, "New Candidates",
                        Icons.school_outlined, const Color(0xff60a3fc)),
                    countWidget(
                      const Color(0xfffaecea),
                      700,
                      "Candidates Hired",
                      Icons.people_alt_outlined,
                      const Color(0xffeba993),
                    ),
                    countWidget(
                      const Color.fromARGB(255, 200, 222, 217),
                      700,
                      "Active Jobs",
                      Icons.work_outline_outlined,
                      const Color(0xff446d67),
                    ),
                    countWidget(const Color(0xfff9f4ed), 700, "Average Salary",
                        Icons.currency_rupee, const Color(0xfff29f50)),
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
                    const Text("Jobs",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),

                    const SizedBox(
                        height:
                            20), // Adding some space between the text and list

                    // Use FutureBuilder to wait for data before building the list
                    Expanded(
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: futureJobList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While waiting for the data, show a loading indicator
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // If there's an error, display an error message
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            // Assuming 'jobs' is a list in the response data
                            List<dynamic> jobs = snapshot.data!['jobDet'];

                            // Build the ListView with dynamic data
                            return ListView.builder(
                              itemCount: jobs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var job = jobs[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Jobdetails(
                                              title: job['job_title'],
                                              jobType: job['job_type'],
                                              result: job['requirements'],
                                              status: job['status'],
                                              salary: job['salary'],
                                              about: job['	job_description']

                                            ),
                                          ),
                                        );
                                      },
                                      child: jobList(
                                        job['job_title'],
                                        job['status'],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
