import 'dart:convert';
import 'package:http/http.dart' as http;
//Employer

Future<Map<int, String>> collegelist() async {
  final String url =
      'http://localhost/Flutter/Api/jobDeal.php?action=clgLIst'; // Replace with your PHP script URL

  try {
    final response = await http.post(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // Decode the response body
      var decodedResponse = jsonDecode(response.body);

      // Extract the colleges list from the response
      // Adjust this based on the actual structure of the response.

      List<dynamic> clgLists = decodedResponse['clgDet'] ?? [];
      Map<int, String> collegeMap = {
        for (var clg in clgLists) int.parse(clg['clg_id']): clg['college_name']
      };
      return collegeMap;
    } else {
      print("Server error: ${response.statusCode}");
      return {}; // Return an empty map on server error
    }
  } catch (e) {
    print("Error: $e");
    return {}; // Return an empty map on network error or other exceptions
  }
}

Future<Map<int, String>> collegeList = collegelist();
