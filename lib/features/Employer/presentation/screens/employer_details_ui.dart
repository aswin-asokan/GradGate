import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/features/Employer/presentation/widgets/employer_details.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';

class EmployerDetailsUi extends StatefulWidget {
  const EmployerDetailsUi({super.key});

  @override
  State<EmployerDetailsUi> createState() => _EmployerDetailsUiState();
}

class _EmployerDetailsUiState extends State<EmployerDetailsUi> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const EmployerDetails()
          : Row(
              children: [ImageSlider(width: width), const EmployerDetails()],
            ),
    );
  }
}
