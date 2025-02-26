import 'package:flutter/material.dart';
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/studentInfo.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/Controller/studCon.dart';


class Studdashboard extends StatefulWidget {
  const Studdashboard({super.key});

  @override
  State<Studdashboard> createState() => _StuddashboardState();
}

class _StuddashboardState extends State<Studdashboard> {
    late Future<Map<String, dynamic>> futureJobList;
  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();
 
    @override
  void initState() {
    super.initState();
    futureJobList = studCont().jobList(); // Call the jobList function from the controller
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
              studentInfo(),
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
                                  // Show dialog with job details
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
                                              'Job Title: ${ job['job_title']}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                            Text('Status: ${ job['status']}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20)),
                                            const SizedBox(height: 10),
                                            // Show Accept/Reject options if the user is selected
                                            if ( job['status'] == 'selected')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'You have been selected for this position!',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.green[300],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          onPressed: ()async {
            Map<String, dynamic>  result = await studCont().offUpdate(int.parse(job['application_id']),1);
                                                           if(result['success']==true) {Navigator.of(
                                                                    context)
                                                                .pop();
                                                            toast(
                                                                "Acceted",
                                                                "You have Accept the offer.",
                                                                context);
                                                          }else
                                                          {Navigator.of(
                                                                    context)
                                                                .pop();
                                                            toast(
                                                                "Can't Accept!",
                                                                "You have already accepted one offer.",
                                                                context);
                                                          }},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  const WidgetStatePropertyAll(
                                                                      Colors
                                                                          .black87),
                                                              shape: WidgetStateProperty.all(
                                                                  const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5))))),
                                                          child: const Text(
                                                            'Accept Offer',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 50,
                                                        child: ElevatedButton(
                                                          onPressed: () async{
 Map<String, dynamic>  result = await studCont().offUpdate(job['application_id'],0);
                                                           if(result['success']==true) {                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            toast(
                                                                "Rejected",
                                                                "You have rejected the offer.",
                                                                context);
                                                           } },
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  const WidgetStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          239,
                                                                          123,
                                                                          123)),
                                                              shape: WidgetStateProperty.all(
                                                                  const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5))))),
                                                          child: const Text(
                                                            'Reject Offer',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            else
                                              const Text(
                                                  'You are not selected for this position yet.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                          ],
                                        ),
                                        actions: [
                                          if ( job['status'] != 'Selected')
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
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
