import 'package:flutter/material.dart';
import 'package:gradgate/features/Student/presentation/widgets/student_details.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';

class StudentDetailsUi extends StatefulWidget {
  const StudentDetailsUi({super.key});

  @override
  State<StudentDetailsUi> createState() => _StudentDetailsUiState();
}

class _StudentDetailsUiState extends State<StudentDetailsUi> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const StudentDetails()
          : Row(
              children: [ImageSlider(width: width), const StudentDetails()],
            ),
    );
  }
}
