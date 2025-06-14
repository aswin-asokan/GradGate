import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class StudentDepartment extends StatefulWidget {
  const StudentDepartment({super.key});

  @override
  State<StudentDepartment> createState() => _StudentDepartmentState();
}

class _StudentDepartmentState extends State<StudentDepartment> {
  String? selectedDepartment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Department",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity, // Set width to full width of parent
          padding:
              const EdgeInsets.symmetric(horizontal: 12.0), // Optional padding
          decoration: BoxDecoration(
            color: textField, // Set grey background color
            borderRadius:
                BorderRadius.circular(5.0), // Optional rounded corners
            border: Border.all(color: textField), // Add border if needed
          ),
          child: DropdownButton<String>(
            value: selectedDepartment,
            hint: const Text("Choose Department"),
            isExpanded: true, // Expands the dropdown to full width
            underline: const SizedBox(), // Removes the underline
            items: departments.map((String department) {
              return DropdownMenuItem<String>(
                value: department,
                child: Text(department),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedDepartment = newValue;
                stuDepartment = selectedDepartment;
              });
            },
            dropdownColor:
                Colors.grey.shade200, // Optional: Change dropdown color
          ),
        ),
      ],
    );
  }
}
