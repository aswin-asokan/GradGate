import 'package:flutter/material.dart';
import 'package:gradgate/features/Employer/presentation/screens/job_details.dart';
import 'package:gradgate/features/Employer/presentation/widgets/count_widget.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/features/Employer/presentation/widgets/job_list.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class EmployerDashboard extends StatefulWidget {
  const EmployerDashboard({super.key});

  @override
  State<EmployerDashboard> createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {
  late Future<List<Map<String, dynamic>>> futureJobList;
  int candidates = 0, hired = 0, activeJobs = 0, avgSalary = 0;
  void fetchStats() async {
    final stats = await DBHelper().getCompanyStats(userID);
    setState(() {
      candidates = stats['applications'];
      hired = stats['hired'];
      activeJobs = stats['activeJobs'];
      avgSalary = (stats['averageSalary']);
    });
  }

  @override
  void initState() {
    super.initState();
    futureJobList = DBHelper().getJobsForEmployer(varMail);
    fetchStats();
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
                    const Text("Jobs",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900)),

                    const SizedBox(
                        height:
                            20), // Adding some space between the text and list

                    // Use FutureBuilder to wait for data before building the list
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: futureJobList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            List<Map<String, dynamic>> jobs = snapshot.data!;

                            return ListView.builder(
                              itemCount: jobs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final job = jobs[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Jobdetails(
                                              title: job['title'] ??
                                                  'Untitled Job',
                                              jobType:
                                                  job['type'] ?? 'Unknown Type',
                                              result: 1,
                                              status: job['status'] ??
                                                  'Unknown Status',
                                              salary: job['salary'] ??
                                                  'Not Specified',
                                              about: job['description'] ??
                                                  'No Description',
                                              jobId:
                                                  job['id']?.toString() ?? '',
                                            ),
                                          ),
                                        );
                                        if (result == true) {
                                          setState(() {});
                                        }
                                      },
                                      child: JobList(
                                        title: job['title'] ?? 'Untitled Job',
                                        status:
                                            job['status'] ?? 'Unknown status',
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
