import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'package:gradgate/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Usercont {
  // Function to add Employer
  Future<Map<String, dynamic>> addUser( String user_id,String about) async {
    final String url = 'http://localhost/Flutter/Api/insert_emp.php?action=addEmp'; // Replace with your PHP script URL

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'user_id' : user_id,
          'comp_name': var_name,
          'location': var_loc,
          'ind_type': var_type,
          'phone': var_phone,
           'about': about,
            'imgUrl': urlImg,
        },
      );
      

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decode the response
      } else {
        print("Server error: ${response.statusCode}");
        return {'success': false}; // Return false on error
      }
    } catch (e) {
      print("Error: $e");
      return {'success': false}; // Return false on exception
    }
  }
 
  // Functio to post job
  Future<Map<String, dynamic>> postJob(String job_desc) async {
    final String url = 'http://localhost/Flutter/Api/insert_emp.php?action=postJob'; // Replace with your PHP script URL

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? user_id = prefs.getString('userId') ??'no value';
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userId' : user_id,
          'job_title': job_title,
          'job_description': job_desc,
          'salary': salary,
          'job_type':job_type,
          'department': department,          
          'requirements': reqrmt,
          'end_date': end_date,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decode the response
      } else {
        print("Server error: ${response.statusCode}");
        return {'success': false}; // Return false on error
      }
    } catch (e) {
      print("Error: $e");
      return {'success': false}; // Return false on exception
    }
  }

  // Function to retrieve jobList
  Future<Map<String, dynamic>> jobList() async {

     try {
       final String url = 'http://localhost/Flutter/Api/insert_emp.php?action=jobList'; 
      // Get user ID from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId') ?? 'no value';

      // Make the POST request to the API
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userId': userId, // Sending the user ID as a parameter
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body
        var decodedResponse = jsonDecode(response.body);

        // Extract the jobs list from the response
        // Assuming your API returns something like {"jobData": [...] }
        // Adjust this based on the actual structure of the response.
        List<dynamic> jobLists = decodedResponse['jobData'] ?? [];

        // Return the data in the format {'jobDet': jobData}
        return {'jobDet': jobLists};
      } else {
        print("Server error: ${response.statusCode}");
        return {'jobDet': []}; // Return an empty list on server error
      }
    } catch (e) {
      print("Error: $e");
      return {'jobDet': []}; // Return an empty list on exception
    }
   
  }
}

