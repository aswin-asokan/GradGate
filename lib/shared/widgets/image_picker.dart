import 'package:flutter/material.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';
import 'package:gradgate/shared/extensions/variables.dart';

// ignore: must_be_immutable
class ImagePicker extends StatefulWidget {
  double width;
  String path;
  ImagePicker({super.key, required this.width, required this.path});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  TextEditingController url = TextEditingController();
  String? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage:
              (image == null) ? AssetImage(widget.path) : NetworkImage(image!),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ClipOval(
            child: Container(
              color: const Color.fromARGB(255, 187, 210, 250),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                color: Colors.white,
                onPressed: openDialog, // Trigger file picker
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Enter URL"),
            content: SizedBox(
              height: 100,
              width: widget.width * 0.3,
              child: CustomTextfield(
                  hint: "Enter URL for logo here",
                  head: "URL",
                  controller: url,
                  type: TextInputType.text),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      image = url.text.trim();
                      urlImg = image!;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ));
}
