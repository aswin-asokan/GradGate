import 'dart:convert';
import 'package:http/http.dart' as http;

// Global variables for Employer statistics
int avgSal = 0;
int count = 0;
int accCount = 0;
int actCount = 0;

// Function to fetch data and update global variables
 void fetchData() async {
 final String url = 'http://localhost/Flutter/Api/loginDet.php?action=count';

    // Make the POST request to the API
    final response = await http.post(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      // Decode the response
          Map<String, dynamic> result = jsonDecode(response.body);
          avgSal = int.parse(result['avg_sal']); // Use null-aware operator to prevent null
      count = int.parse(result['c_appl']); 
      accCount = int.parse(result['r_appl']);
      actCount = int.parse(result['active']);
          }

  // After fetching the data, you can update your UI or do further processing
}

