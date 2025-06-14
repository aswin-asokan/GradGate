import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/Profile/presentation/screens/settings.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late QuillController _controller;
  late String plainText;
  @override
  void initState() {
    super.initState();
    // Initialize the QuillController with the document
    _controller = QuillController(
      document: varAboutJS,
      selection: const TextSelection.collapsed(offset: 0),
    );

    // Convert document to plain text
    plainText = _controller.document.toPlainText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      // Optional: Add box shadow for better visibility
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 200,
                    clipBehavior: Clip
                        .antiAlias, // Ensures the image fits within the rounded edges
                    child: Image.asset(
                      "assets/images/White Minimalist Corporate Personal Profile LinkedIn Banner.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors
                          .transparent, // Optional: Set a background color if needed
                      child: ClipOval(
                        child: urlImg ==
                                "assets/images/no-profile-picture-15258 (1).png"
                            ? Image.asset(
                                "assets/images/no-profile-picture-15258 (1).png",
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to fill the CircleAvatar
                                width:
                                    200, // Set the width to be double the radius
                                height:
                                    200, // Set the height to be double the radius
                              )
                            : Image.network(
                                urlImg,
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to fill the CircleAvatar
                                width:
                                    200, // Set the width to be double the radius
                                height:
                                    200, // Set the height to be double the radius
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                          ))),
                  if (stAccess == "Student" || stAccess == "Employer")
                    Positioned(
                        right: 70,
                        top: 10,
                        child: IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Settings()),
                              );
                              if (result == true) {
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.settings_outlined,
                              size: 30,
                            )))
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                varName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    stAccess == "Student"
                        ? Icons.book
                        : Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Wrap the Text in Flexible to allow it to take available space
                  Flexible(
                    child: Text(
                      stAccess == "Student" ? stuDepartment! : varLocation,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18 // Responsive font size
                          ),
                      overflow: TextOverflow
                          .ellipsis, // Optional: Ensure text doesn't overflow
                      maxLines: 10, // Optional: Limit to one line
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    stAccess == "Employer" ? varType : varCollege,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              Text(
                plainText,
                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Contact us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(
                    Icons.phone_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    varPhone,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    varMail,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
