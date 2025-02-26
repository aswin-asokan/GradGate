import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_quill/flutter_quill.dart';
//Employer

String var_loc = "";
String var_name = "";
String var_phone = "";
String var_type = "";
Document? var_about;
String user_type = "";
var var_aboutJ = Document();
String urlImg = "assets/images/no-profile-picture-15258 (1).png";
String var_mail = "";
//job posting
String job_title = "";
String salary = "";
Document? job_desc ;
String job_type = "";
String department = "";
String reqrmt = "";
String end_date = "";
String aboutComp="";
int job_id= 0;
String apply_job_id = "";
String? stuDepartment;
int selectedCollegeId = 0;
//applications
String statusUp = "";
String StAccess="";

final List<String> departments = [
  "Computer Science",
  "AIML",
  "Computer Science DS",
  "Mechanical",
  "Civil",
  "Electronics",
  "EEE",
];

