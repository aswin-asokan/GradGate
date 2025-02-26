import 'package:flutter/material.dart';
import 'package:gradgate/Profile/viewProfile.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/Controller/userCont.dart';
import 'package:gradgate/variables.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert'; // Import to handle JSON parsing



// ignore: must_be_immutable
class Jobdetails extends StatefulWidget {
  String title;
  String salary;
  String jobType;
  String status;
  String about;
  var result;
  String job_id;

  Jobdetails(
      {super.key,
      required this.title,
      required this.jobType,
      required this.result,
      required this.status,
      required this.salary,
      required this.about,
     required this.job_id});


  @override
  State<Jobdetails> createState() => _JobdetailsState();
}
 
Color color = Colors.black;

class _JobdetailsState extends State<Jobdetails> {
  late Future<Map<String, dynamic>> studentList;
  late quill.Document aboutDocument;

  var stud;

  @override
  void initState() {
    super.initState();
    studentList = Usercont().studList(widget.job_id); 
  }
/*  List<String> name = ["aswin", "abcd", "efgh"];
  List<String> status = ["applied", "selected", "applied"];*/

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
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              const Text(
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
                height: 600, // Outer container height
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
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: studentList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While waiting for the data, show a loading indicator
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // If there's an error, display an error message
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            // Assuming 'jobs' is a list in the response data
                            List<dynamic> studDet = snapshot.data!['stuDet'];

                            // Build the ListView with dynamic data
                            return ListView.builder(
                              itemCount: studDet.length,
                              itemBuilder: (BuildContext context, int index) {
                                stud = studDet[index];
                                return Column(
                                
                                  children: [
                              GestureDetector(
                                  onTap: () {
                                     String department =stud['dpartment'];
                                     if (department == "CSE") {
        department = "Computer Science";  // Set department1 to "CS"
    } else if (department =="DS" ) {
        department = "Computer Science DS" ;  
    }
    else if (department == "ME") {
        department = "Mechanical";  
    }
    else if (department =="CE" ) {
        department = "Civil";  
    }
    else if(department =="EC" ) {
        department = "Electronics" ;
    }    
                                    final List<dynamic> aboutJson  = jsonDecode(stud['about']);

           aboutDocument = quill.Document.fromJson(aboutJson);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Viewprofile(
                                        name :stud['name'],
                                         userType:"Student", 
                                        imgLink:stud['img_url'],
                                        nameOrCompany : stud['name'],
                                        depOrType : department ,
                                        locationOrCollege : stud['college_name'],
                                        mail : stud['mail_id'],
                                        phone :stud['phone'],
                                        about : aboutDocument,
                                                  
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      studetData(
                                          stud['name'], stud['status'],stud),
                                      
                                      if (stud['status'] == "selected")
                                        studentReply(stud['response'])
                                    ],
                                  ),),
                              const SizedBox(
                                height: 10,
                              )
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
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 25,
                runSpacing: 25,
                children: [
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.redAccent),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))))),
                      onPressed: () {
                        // Handle change password logic here
                        toast(
                            "Status Changed",
                            "The job status has been updated to closed.",
                            context);
                      },
                      child: const Text("Change Status to Closed",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.blueAccent),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))))),
                      onPressed: () {
                        // Handle change password logic here
                        toast(
                            "Status Changed",
                            "The job status has been updated to in progress.",
                            context);
                      },
                      child: const Text("Change Status to In Progress",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget studetData(String name, String currentStatus, var stud) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: secBg // Change to your secBg color
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
                value: stud['status'],
                onChanged: (String? newValue) {
                  setState(() {
                    stud['status'] = newValue!;
                    statusUp = newValue;
                    if (stud['status'] == "selected") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                                "The student is already in a selected position in another company. You may add some students to waitlist."),
                            actions: [
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("OK"),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
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
              const SizedBox(
                width: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                    onPressed: () {
                       Usercont().studUpdate(statusUp,stud['application_id']);

                      toast(
                          "Updated", "Updated the candidate details", context);
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.blueAccent,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget jobStat(String head, String value) {
  if (value == "Active" || value == "Selected") {
    color = Colors.green;
  } else if (value == "In Progress" || value == "Applied") {
    color = Colors.blue;
  } else if (value == "Closed" || value == "Rejected") {
    color = Colors.red;
  } else if (value == "Waitlist" || value == "Shortlist") {
    color = Colors.orangeAccent;
  } else {
    color = Colors.black;
  }
  return Row(
    children: [
      Text(
        head,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      const SizedBox(
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
