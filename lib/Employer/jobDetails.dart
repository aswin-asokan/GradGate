import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';

// ignore: must_be_immutable
class Jobdetails extends StatefulWidget {
  String title;
  double salary;
  String jobType;
  String status;
  var result;
  Jobdetails(
      {super.key,
      required this.title,
      required this.jobType,
      required this.result,
      required this.status,
      required this.salary});

  @override
  State<Jobdetails> createState() => _JobdetailsState();
}

class _JobdetailsState extends State<Jobdetails> {
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
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                Divider(),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                jobStat("Status:", widget.status),
                jobStat("Type:   ", widget.jobType),
                jobStat("Salary:", widget.salary.toString()),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 650, // Outer container height
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
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                GestureDetector(),
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
        ));
  }
}

Widget jobStat(String head, String value) {
  return Row(
    children: [
      Text(
        head,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        value,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
    ],
  );
}
