import 'package:flutter_quill/flutter_quill.dart';

//Employer
int userID = 0;
String varLocation = "";
String varName = "";
String varPassword = "";
String varPhone = "";
String varType = "";
String varCollege = "";
Document? varAbout;
String userType = "";
var varAboutJS = Document();
String urlImg = "assets/images/no-profile-picture-15258 (1).png";
String varMail = "";
//job posting
String jobTitle = "";
String salary = "";
Document? jobDescription;
String jobType = "";
String department = "";
String reqrmt = "";
String endDate = "";
Document? aboutComp;
String compType = "";
int jobID = 0;
String applyJobID = "";
String? stuDepartment;
int selectedCollegeId = 0;
//applications
String statusUp = "";
String stAccess = "";

final List<String> departments = [
  "Computer Science",
  "AIML",
  "Computer Science DS",
  "Mechanical",
  "Civil",
  "Electronics",
  "EEE",
];
