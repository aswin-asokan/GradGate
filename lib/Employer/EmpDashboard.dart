import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';

class Empdashboard extends StatefulWidget {
  const Empdashboard({super.key});

  @override
  State<Empdashboard> createState() => _EmpdashboardState();
}

class _EmpdashboardState extends State<Empdashboard> {
  TextEditingController jobname = new TextEditingController();
  TextEditingController info = new TextEditingController();
  List<String> title = ["Job1", "Job2", "Job3"];
  List<String> status = ["Active", "In Progress", "Closed"];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: secBg,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      children: [
                        countWidget(Color(0xffeaf2fd), 700, "New Candidates",
                            Icons.school_outlined, Color(0xff60a3fc)),
                        countWidget(Color(0xfffaecea), 700, "Candidates Hired",
                            Icons.people_alt_outlined, Color(0xffeba993)),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      children: [
                        countWidget(
                            Color.fromARGB(255, 200, 222, 217),
                            700,
                            "Active Jobs",
                            Icons.work_outline_outlined,
                            Color(0xff446d67)),
                        countWidget(Color(0xfff9f4ed), 700, "Average Salary",
                            Icons.currency_rupee, Color(0xfff29f50)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 500, // Outer container height
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
                              jobList(title[index], status[index]),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
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
