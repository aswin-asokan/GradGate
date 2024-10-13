import 'package:flutter/material.dart';
import 'package:gradgate/Profile/viewProfile.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';

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

Color color = Colors.black;

class _JobdetailsState extends State<Jobdetails> {
  List<String> name = ["aswin", "abcd", "efgh"];
  List<String> status = ["applied", "selected", "applied"];

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              Divider(),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 5,
              ),
              jobStat("Status :", widget.status),
              jobStat("Type    :", widget.jobType),
              jobStat("Salary :", widget.salary.toString()),
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
                                  child: studetData(
                                      name[index], status[index], index)),
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

  Widget studetData(String name, String currentStatus, int index) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey[200], // Change to your secBg color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Student name
          Text(
            name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          // Dropdown menu for student status
          Row(
            children: [
              DropdownButton<String>(
                value: currentStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    status[index] = newValue!;
                  });
                },
                items: <String>[
                  'applied',
                  'shortlisted',
                  'selected',
                  'rejected',
                  'waitlist',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    toast("Updated", "Updated the candidate details", context);
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.blueAccent,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

Widget jobStat(String head, String value) {
  if (value == "Active") {
    color = Colors.green;
  } else if (value == "In Progress") {
    color = Colors.blue;
  } else if (value == "Closed") {
    color = Colors.red;
  } else {
    color = Colors.black;
  }
  return Row(
    children: [
      Text(
        head,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        value,
        style:
            TextStyle(fontWeight: FontWeight.w400, fontSize: 25, color: color),
      ),
    ],
  );
}
