import 'package:flutter/material.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';

// ignore: must_be_immutable
class ProfileImage extends StatefulWidget {
  double width;
  String path;
  ProfileImage({super.key, required this.width, required this.path});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  TextEditingController url = new TextEditingController();
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
            title: Text("Enter URL"),
            content: Container(
              height: 100,
              width: widget.width * 0.3,
              child: customTextField("Enter URL for logo here", "URL", url,
                  TextInputType.text, null),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      image = url.text.toString().trim();
                      urlImg = image;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ));
}

class editProImg extends StatefulWidget {
  final double width;
  String path;

  editProImg({super.key, required this.width, required this.path});

  @override
  State<editProImg> createState() => _editProImgState();
}

class _editProImgState extends State<editProImg> {
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
          title: Text("Enter URL"),
          content: Container(
            height: 100,
            width: widget.width * 0.3,
            child: customTextField(
              "Enter URL for logo here",
              "URL",
              url,
              TextInputType.text,
              null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  image = url.text.trim(); // Set new image URL
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
}
