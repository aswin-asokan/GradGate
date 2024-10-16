import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:http/http.dart' as http;

class Usercont {
  // Function to add Employer
  Future<Map<String, dynamic>> addUser( String user_id,String var_loc,String var_name,String var_phone,String var_type,String about,String imageUrl) async {
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
            'imgUrl': imageUrl,
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
 
  // Function to verify user credentials
  Future<Map<String, dynamic>> postJob(String email, String password,String type) async {
    final String url = 'http://localhost/Flutter/Api/loginDet.php?action=signup'; // Replace with your PHP script URL

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'mail': email,
          'password': password,
          'type':type,
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

