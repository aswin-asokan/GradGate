import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/variables.dart';
import 'dart:convert'; // Ensure this import for JSON encoding/decoding

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
  
}


class _ProfileState extends State<Profile> {
 late  QuillController _controller ;
  late String plainText;
    @override
  void initState() {
    super.initState();

    // Assuming 'about' is a JSON string containing the Quill document
    var aboutDec = jsonDecode(aboutComp);
    
    // Create a Delta from the decoded JSON
    Delta delta = Delta.fromJson(aboutDec);

    // Create a Quill Document from the Delta
    Document document = Document.fromDelta(delta);

    // Initialize the QuillController with the document
    _controller = QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: 0),
    );

    // Convert document to plain text
    plainText = _controller.document.toPlainText();
    print(plainText); // Print plain text for debugging
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
              Container(
                height: 300,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // Optional: Add box shadow for better visibility
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
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
                          
                          if(StAccess == "Student")
                  Positioned(
                      right: 70,
                      top: 10,
                      child: IconButton(
                          onPressed: () {

                              Navigator.pushNamed(context, '/studSettings');
                            
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 30,
                          )))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                var_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Wrap the Text in Flexible to allow it to take available space
                  Flexible(
                    child: Text(
                      var_loc,
                      style: TextStyle(
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    var_type,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Divider(),
              Container(
                child:  Text(
                plainText,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
                
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Contact us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Divider(),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    var_phone,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    var_mail,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
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
