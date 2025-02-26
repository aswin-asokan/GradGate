// location_autocomplete.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:http/http.dart' as http;

class LocationAutocomplete extends StatefulWidget {
  final TextEditingController locationController;

  LocationAutocomplete({required this.locationController});

  @override
  _LocationAutocompleteState createState() => _LocationAutocompleteState();
}

class _LocationAutocompleteState extends State<LocationAutocomplete> {
  List<String> _locationSuggestions = [];
  bool _isLoading = false;

  // Fetch location suggestions from Nominatim API
  Future<void> _fetchLocationSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _locationSuggestions = [];
      });
      return;
    }

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5');

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          _locationSuggestions = data
              .map((item) => item['display_name'] as String)
              .toList(); // Extract display names
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.locationController,
          onChanged: (value) {
            _fetchLocationSuggestions(value);
          },
          decoration: InputDecoration(
              hintText: 'Enter Location',
              prefixIcon: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    )
                  : Icon(Icons.location_on),
              hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              counterText: "",
              fillColor: textField,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: textField),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: textField),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: textField),
              )),
        ),
        // Display location suggestions
        if (_locationSuggestions.isNotEmpty)
          Container(
            constraints:
                BoxConstraints(maxHeight: 200), // Limit dropdown height
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _locationSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_locationSuggestions[index]),
                  onTap: () {
                    // Set selected location in the text field
                    widget.locationController.text =
                        _locationSuggestions[index];
                    setState(() {
                      _locationSuggestions = [];
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
