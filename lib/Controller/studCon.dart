import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradgate/variables.dart';





class studCont {
  
  // Function to add Employer
  Future<Map<String, dynamic>> addStud() async {
    final String url = 'http://localhost/Flutter/Api/student.php?action=addStud'; // Replace with your PHP script URL

    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();

       String? user_id = prefs.getString('userId') ??'no value';
      
      final response = await http.post(
        Uri.parse(url),
        body: {
          'clg_id': selectedCollegeId.toString(),
          'user_id' : user_id,
          'stud_name': var_name,
          'phone': var_phone,
           'about': aboutComp,
            'imgUrl': urlImg,
            'department' : stuDepartment,
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
       final String url = 'http://localhost/Flutter/Api/student.php?action=jobList'; 
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
// retrieve student details
   Future<Map<String, dynamic>> stdDetails() async {

     try {
       final String url = 'http://localhost/Flutter/Api/student.php?action=stdDet'; 
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
  Future<Map<String, dynamic>> viejobList() async {

     try {
       final String url = 'http://localhost/Flutter/Api/student.php?action=viewJob'; 
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


 
  Future<Map<String, dynamic>> applyJob() async {
    final String url = 'http://localhost/Flutter/Api/student.php?action=apply'; // Replace with your PHP script URL

    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();

       String? user_id = prefs.getString('userId') ??'no value';
      
      final response = await http.post(
        Uri.parse(url),
        body: {
          'job_id': apply_job_id,
          'user_id' : user_id,
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
 // retrieve student details
   Future<Map<String, dynamic>> offUpdate(int app_id,int op) async {

     try {
       final String url = 'http://localhost/Flutter/Api/student.php?action=offerUp'; 
      // Get user ID from shared preferences


      // Make the POST request to the API
      final response = await http.post(
        Uri.parse(url),
        body: {
          'app_id': app_id.toString(), // Sending the user ID as a parameter
                    'op': op.toString(), // Sending the user ID as a parameter

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

  Future<Map<String, dynamic>> delAcc(String password) async {

     try {
       final String url = 'http://localhost/Flutter/Api/student.php?action=delAcc'; 
      // Get user ID from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId') ?? 'no value';


      // Make the POST request to the API
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userId': userId, // Sending the user ID as a parameter password
          'password': password, // Sending the user ID as a parameter password

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
  
  }

