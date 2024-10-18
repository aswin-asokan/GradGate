import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gradgate/variables.dart';


class AuthService {
  // Function to verify user credentials
  Future<Map<String, dynamic>> verifyUser(String password) async {
    final String url = 'http://localhost/Flutter/Api/loginDet.php?action=login'; // Replace with your PHP script URL

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'mail': var_mail,
          'password': password,
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
  Future<Map<String, dynamic>> signUp(String password) async {
    final String url = 'http://localhost/Flutter/Api/loginDet.php?action=signup'; // Replace with your PHP script URL

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'mail': var_mail,
          'password': password,
          'type': var_type,
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

