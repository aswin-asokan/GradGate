import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:gradgate/Employer/EmpWid.dart';
import 'package:gradgate/Profile/viewProfile.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/Controller/collCon.dart';
import 'package:gradgate/allCount.dart';
import 'dart:convert'; // Import to handle JSON parsing



class Collegedashboard extends StatefulWidget {
  const Collegedashboard({super.key});

  @override
  State<Collegedashboard> createState() => _EmpdashboardState();
}

class _EmpdashboardState extends State<Collegedashboard> {
   late Future<Map<String, dynamic>> futureJobList;
     late quill.Document aboutDocument;


  TextEditingController jobname = TextEditingController();
  TextEditingController info = TextEditingController(); 
 
   @override
  void initState() {
    super.initState();
    futureJobList = collCont().stdList(); // Call the jobList function from the controller
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
                    countWidget(const Color(0xffeaf2fd), count, "New Candidates",
                        Icons.school_outlined, const Color(0xff60a3fc)),
                    countWidget(
                      const Color(0xfffaecea),
                      accCount,
                      "Candidates Hired",
                      Icons.people_alt_outlined,
                      const Color(0xffeba993),
                    ),
                    countWidget(
                      const Color.fromARGB(255, 200, 222, 217),
                      actCount,
                      "Active Jobs",
                      Icons.work_outline_outlined,
                      const Color(0xff446d67),
                    ),
                    countWidget(const Color(0xfff9f4ed), avgSal, "Average Salary",
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
                    const Text("Students Placed",
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
                                                 
                                          name :stud['stud_name'],
                                         userType:"Student", 
                                        imgLink:stud['img_url'],
                                        nameOrCompany :stud['stud_name'],
                                        depOrType : department ,
                                        locationOrCollege : stud['college_name'],
                                        mail : stud['mail_id'],
                                        phone :stud['phone'],
                                        about : aboutDocument,
                                                )));
                                  },
                                  child: studetCollege(
                                      stud['stud_name'], stud['company'])),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                                );
                              },
                            );
                       } else {
                            // In case there's no data
                            return const Center(child: Text('No students found.'));}
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
      color: secBg, // Assuming secBg is a defined color
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Wrap title in Expanded to prevent overflow
        Expanded(
          child: Text(
            title,
            softWrap: true,
            maxLines: 1, // Limit to 1 line, adjust based on your preference
            overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10), // Add some spacing between title and company
        // Wrap company in Expanded to prevent overflow
        Expanded(
          child: Text(
            company,
            softWrap: true,
            maxLines: 1, // Limit to 1 line, adjust based on your preference
            overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            textAlign: TextAlign.right, // Align company text to the right
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
