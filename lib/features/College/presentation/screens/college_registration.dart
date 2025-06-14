import 'package:flutter/material.dart';
import 'package:gradgate/features/College/presentation/widgets/college_details.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';

class CollegeRegistration extends StatefulWidget {
  const CollegeRegistration({super.key});

  @override
  State<CollegeRegistration> createState() => _CollegeRegistrationState();
}

class _CollegeRegistrationState extends State<CollegeRegistration> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const CollegeDetails()
          : Row(
              children: [ImageSlider(width: width), const CollegeDetails()],
            ),
    );
  }
}
