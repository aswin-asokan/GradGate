import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:gradgate/Profile/viewProfile.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';
import 'dart:convert'; // Ensure this import for JSON encoding/decoding
import 'package:gradgate/Controller/studCon.dart';


// ignore: must_be_immutable
class Viewjob extends StatefulWidget {
  //select * from jobs where title=jobtitle
String imgLink;
String jobTitle;
String jobCompany;
String jobLocation ;
String lastDate;
String jobSalary ;
String jobType;
String jobAbout;
String jobId;



                              
  Viewjob(
      {super.key,
      required this.jobTitle,
      required this.jobCompany,
      required this.jobType,
      required this.jobLocation,
      required this.lastDate,
      required this.imgLink,
      required this.jobAbout,
      required this.jobSalary,
      required this.jobId,});

  @override
  State<Viewjob> createState() => _ViewjobState();
   }



class _ViewjobState extends State<Viewjob> {

  //late quill.Document aboutDocument;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: secBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipOval(
                        child: widget.imgLink ==
                                "assets/images/no-profile-picture-15258 (1).png"
                            ? Image.asset(
                                "assets/images/no-profile-picture-15258 (1).png",
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to fill the CircleAvatar
                                width:
                                    200, // Set the width to be double the radius
                                height:
                                    200, // Set the height to be double the radius
                              )
                            : Image.network(
                                widget.imgLink,
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to fill the CircleAvatar
                                width:
                                    200, // Set the width to be double the radius
                                height:
                                    200, // Set the height to be double the radius
                              ),
                      ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    // Added to prevent overflow on smaller screens
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                          "${widget.jobTitle}: ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            TextButton(
                                onPressed: () {
                                    //final List<dynamic> aboutJson  = jsonDecode(stud['about']);

           //aboutDocument = quill.Document.fromJson(aboutJson);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Viewprofile(
                                                        
                                          name :"name",
                                         userType:"Student", 
                                        imgLink:"assets/images/no-profile-picture-15258 (1).png",
                                        nameOrCompany : "Google",
                                        depOrType : "Software",
                                        locationOrCollege : "America",
                                        mail : "mail",
                                        phone :"3698",
                                        about : Document(),
                                            )),
                                  );
                                },
                                child: Text(widget.jobCompany,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[300],
                                        fontSize: 25))),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.jobLocation,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 15,
                          runSpacing: 15,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width < 400
                                  ? double.infinity
                                  : 300, // Adjust button width based on screen size
                              height: 50,
                              child: ElevatedButton(
                                onPressed: ()async {
                                    setState(() {
                                       apply_job_id = widget.jobId;
                                        });
                                    Map<String, dynamic>  addResult = await studCont().applyJob();
                                    if(addResult['success'])
                                 {
                
                                  toast("Applied",
                                      "You have applied for the job.", context);}
                                   else
                                 {
                
                                toast("Already Applied",
                                      "You have already applied for the job.", context);
                                      
                                }
                                     
                     
                                 
                                      
                                },
                                
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 100, 181, 246),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                child: const Text(
                                  'Apply Now',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width < 400
                                  ? double.infinity
                                  : 300, // Adjust button width based on screen size
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                      width: 1, color: Colors.black12),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                child: const Text(
                                  'Go Back',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 25,
              ),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    decoration: const BoxDecoration(
                        color: Color(0xffe3dbfa),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Text(
                      widget.lastDate,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    decoration: const BoxDecoration(
                        color: Color(0xffffe1cc),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Text(
                    "Salary: \$${widget.jobSalary}/m",
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    decoration: const BoxDecoration(
                        color: Color(0xfffbe2f4),
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Text(
                      widget.jobType,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
 child:  Text(
                widget.jobAbout,
                style: TextStyle(fontSize: 18,color: const Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w600),
              ),

                  ),
            ],
          ),
        ),
      ),
    );
  }
}
