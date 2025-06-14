import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.head,
      required this.hint,
      this.max = 1000000,
      required this.type});
  final String hint;
  final String head;
  final TextEditingController controller;
  final TextInputType type;
  final int max;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          maxLength: max,
          keyboardType: type,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
        ),
      ],
    );
  }
}
