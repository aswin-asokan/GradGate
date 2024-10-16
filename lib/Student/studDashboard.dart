import 'package:flutter/material.dart';
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';

class Studdashboard extends StatefulWidget {
  const Studdashboard({super.key});

  @override
  State<Studdashboard> createState() => _StuddashboardState();
}

class _StuddashboardState extends State<Studdashboard> {
  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();
  List<String> title = ["Job1", "Job2", "Job3", "Job1", "Job2"];
  List<String> status = [
    "Applied",
    "Short Listed",
    "Selected",
    "Rejected",
    "Wait List",
  ];

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

                    // Wrap ListView in Expanded to take the remaining space
                    Expanded(
                      child: ListView.builder(
                        itemCount: title.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Show dialog with job details
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Job Details'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Job Title: ${title[index]}'),
                                            Text('Status: ${status[index]}'),
                                            const SizedBox(height: 10),
                                            // Show Accept/Reject options if the user is selected
                                            if (status[index] == 'Selected')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'You have been selected for this position!',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          // Accept offer logic here
                                                          Navigator.of(context)
                                                              .pop();
                                                          toast(
                                                              "Rejected",
                                                              "You have accepted the offer!",
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Accept'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          // Reject offer logic here
                                                          Navigator.of(context)
                                                              .pop();
                                                          toast(
                                                              "Rejected",
                                                              "You have rejected the offer.",
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red),
                                                        child: const Text(
                                                            'Reject'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            else
                                              const Text(
                                                  'You are not selected for this position yet.'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: jobList(title[index], status[index]),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
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
