import 'package:flutter/material.dart';
import 'package:gradgate/features/Student/presentation/widgets/student_registration.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';

class StudRegistrationUi extends StatefulWidget {
  const StudRegistrationUi({super.key});

  @override
  State<StudRegistrationUi> createState() => _StudRegistrationUiState();
}

class _StudRegistrationUiState extends State<StudRegistrationUi> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const StudentRegistration()
          : Row(
              children: [
                ImageSlider(width: width),
                const StudentRegistration()
              ],
            ),
    );
  }
}
