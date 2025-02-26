import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradgate/variables.dart';





class collCont {
  
  // Function to add Employer
  Future<Map<String, dynamic>> addColl() async {
    final String url = 'http://localhost/Flutter/Api/college.php?action=addColl'; // Replace with your PHP script URL

    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();

       String? user_id = prefs.getString('userId') ??'no value';
      
      final response = await http.post(
        Uri.parse(url),
        body: {
          'user_id' : user_id,
          'var_name': var_name,
          'phone': var_phone,
          'location': var_loc,
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
  Future<Map<String, dynamic>> stdList() async {

     try {
       final String url = 'http://localhost/Flutter/Api/college.php?action=stdList'; 
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
        List<dynamic> stdLists = decodedResponse['stdData'] ?? [];

        // Return the data in the format {'jobDet': jobData}
        return {'stdData': stdLists};
      } else {
        print("Server error: ${response.statusCode}");
        return {'stdData': []}; // Return an empty list on server error
      }
    } catch (e) {
      print("Error: $e");
      return {'stdData': []}; // Return an empty list on exception
    }
   
  }
  
  // retrieve college details
   Future<Map<String, dynamic>> collDetails() async {

     try {
       final String url = 'http://localhost/Flutter/Api/college.php?action=collDet'; 
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
  }

