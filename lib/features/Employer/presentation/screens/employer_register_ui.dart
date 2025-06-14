import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';
import 'package:gradgate/features/Employer/presentation/widgets/employer_register.dart';

class EmployerRegisterUi extends StatefulWidget {
  const EmployerRegisterUi({super.key});

  @override
  State<EmployerRegisterUi> createState() => _EmployerRegisterUiState();
}

class _EmployerRegisterUiState extends State<EmployerRegisterUi> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const Empregister()
          : Row(
              children: [ImageSlider(width: width), const Empregister()],
            ),
    );
  }
}
