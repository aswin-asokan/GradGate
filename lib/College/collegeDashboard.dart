import 'package:flutter/material.dart';
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/Profile/viewProfile.dart';
import 'package:gradgate/colors.dart';

class Collegedashboard extends StatefulWidget {
  const Collegedashboard({super.key});

  @override
  State<Collegedashboard> createState() => _EmpdashboardState();
}

class _EmpdashboardState extends State<Collegedashboard> {
  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController();
  List<String> name = [
    "Stuednt 1",
    "Student 2",
    "student 3",
    "Stuednt 1",
    "Student 2",
    "student 3"
  ];
  List<String> company = [
    "Company X",
    "Company X",
    "Company X",
    "Company X",
    "Company X",
    "Company X"
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
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      children: [
                        countWidget(
                            const Color(0xffeaf2fd),
                            700,
                            "Student Candidates",
                            Icons.school_outlined,
                            const Color(0xff60a3fc)),
                        countWidget(
                            const Color(0xfffaecea),
                            700,
                            "Students Hired",
                            Icons.people_alt_outlined,
                            const Color(0xffeba993)),
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      children: [
                        countWidget(
                            const Color.fromARGB(255, 200, 222, 217),
                            700,
                            "Active Jobs",
                            Icons.work_outline_outlined,
                            const Color(0xff446d67)),
                        countWidget(
                            const Color(0xfff9f4ed),
                            700,
                            "Average Salary",
                            Icons.currency_rupee,
                            const Color(0xfff29f50)),
                      ],
                    ),
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
                      child: ListView.builder(
                        itemCount: name.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Viewprofile(
                                                name: name[index])));
                                  },
                                  child: studetCollege(
                                      name[index], company[index])),
                              const SizedBox(
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

Widget studetCollege(String title, String company) {
  return Container(
    height: 80,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: secBg),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          company,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}
