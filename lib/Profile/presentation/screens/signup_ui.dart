import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/shared/widgets/image_slide.dart';
import 'package:gradgate/Profile/presentation/widgets/sign_up.dart';

class SignupUi extends StatefulWidget {
  const SignupUi({super.key});

  @override
  State<SignupUi> createState() => _SignupUiState();
}

class _SignupUiState extends State<SignupUi> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
      body: width < 800
          ? const SignUp()
          : Row(
              children: [ImageSlider(width: width), const SignUp()],
            ),
    );
  }
}
