import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

// ignore: must_be_immutable
class ViewProfile extends StatefulWidget {
  String name;
  String userType;
  String imgLink;
  String nameOrCompany;
  String depOrType;
  String locationOrCollege;
  String mail;
  String phone;
  Document about = Document();
  ViewProfile({
    super.key,
    required this.name,
    required this.userType,
    required this.imgLink,
    required this.nameOrCompany,
    required this.depOrType,
    required this.locationOrCollege,
    required this.mail,
    required this.phone,
    required this.about,
  });

  @override
  State<ViewProfile> createState() => _ProfileState();
}

class _ProfileState extends State<ViewProfile> {
  late Document about = widget.about;

  late final QuillController _controller = QuillController(
      document: widget.about,
      selection: const TextSelection(baseOffset: 0, extentOffset: 0),
      readOnly: true);
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
                        child: widget.imgLink ==
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
                                widget.imgLink,
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
                      left: 20,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          )))
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.nameOrCompany,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Wrap the Text in Flexible to allow it to take available space
                  Flexible(
                    child: Text(
                      widget.locationOrCollege,
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
                    widget.depOrType,
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
              QuillEditor.basic(
                controller: _controller,
                config: const QuillEditorConfig(scrollable: false),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Contact",
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
                    widget.phone,
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
                    widget.mail,
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
