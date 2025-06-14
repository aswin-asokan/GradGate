import 'package:flutter/material.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_textfield.dart';

class EditProfileImage extends StatefulWidget {
  final double width;
  final String path;

  const EditProfileImage({super.key, required this.width, required this.path});

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  TextEditingController url = TextEditingController();
  String? image;

  @override
  void initState() {
    super.initState();
    image = widget.path; // Initialize with the default path
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: image!.startsWith('http')
              ? NetworkImage(image!) as ImageProvider
              : AssetImage(widget.path),
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
              type: TextInputType.text,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  image = url.text.trim(); // Set new image URL
                  urlImg = image!;
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
}
