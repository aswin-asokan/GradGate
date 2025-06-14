import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

class MultiLineText extends StatelessWidget {
  const MultiLineText(
      {super.key, required this.controller, required this.head});
  final QuillController controller;
  final String head;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          head,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        QuillSimpleToolbar(
          controller: controller,
          config: const QuillSimpleToolbarConfig(showInlineCode: false),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: textField,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          height: 300, // Set a fixed height
          child: QuillEditor.basic(
            controller: controller,
            config: const QuillEditorConfig(),
          ),
        ),
      ],
    );
  }
}
