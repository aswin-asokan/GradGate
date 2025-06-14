import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class SelectCollege extends StatelessWidget {
  const SelectCollege({super.key, required this.collegesFuture});
  final Future<Map<int, String>> collegesFuture;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "College",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<Map<int, String>>(
          future: collegesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text("Error loading colleges");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No colleges available");
            } else {
              final colleges = snapshot.data!;

              return Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return colleges.values.where((String collegeName) {
                    return collegeName.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                onSelected: (String selectedCollegeName) {
                  selectedCollegeId = colleges.entries
                      .firstWhere(
                        (entry) => entry.value == selectedCollegeName,
                      )
                      .key;
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: "Enter college name",
                      hintStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
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
                      ),
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              textField, // Same background color as TextField
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: textField), // Match borders
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return ListTile(
                              title: Text(option),
                              onTap: () {
                                onSelected(option);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
