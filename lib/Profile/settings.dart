import 'dart:convert';

import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imgPicker.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/database/employer.dart';
import 'package:gradgate/variables.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  QuillController _controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    String? jsonAbout;
    _controller.document = var_about!;
    TextEditingController name = new TextEditingController(text: var_name);
    TextEditingController location = new TextEditingController(text: var_loc);
    TextEditingController type = new TextEditingController(text: var_type);
    TextEditingController phone = new TextEditingController(text: var_phone);
    TextEditingController mail = new TextEditingController(text: var_mail);
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
                      child: editProImg(width: width, path: urlImg!)),
                  Positioned(
                      left: 20,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 30,
                          )))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                decoration: InputDecoration(border: InputBorder.none),
              ),
              SizedBox(
                height: 10,
              ),
              LocationAutocomplete(locationController: location),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: type,
                style: TextStyle(fontSize: 18, color: Colors.grey),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Divider(),
              QuillSimpleToolbar(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: QuillEditor.basic(
                  controller: _controller,
                  configurations:
                      const QuillEditorConfigurations(scrollable: false),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Contact us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Divider(),
              TextField(
                controller: phone,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 18, color: Colors.grey),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: mail,
                style: TextStyle(fontSize: 18, color: Colors.grey),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      bool mailvalid = EmailValidatorFlutter()
                          .validateEmail(mail.text.toString());
                      if (!mailvalid) {
                        toast(
                            "Invalid mail ID",
                            "The email you have entered is not valid. Try again.",
                            // ignore: use_build_context_synchronously
                            context);
                      } else if (name.text.isNotEmpty &&
                          location.text.isNotEmpty &&
                          phone.text.isNotEmpty &&
                          type.text.isNotEmpty) {
                        setState(() {
                          var_mail = mail.text.toString();
                          var_about = _controller.document;
                          var_loc = location.text.toString();
                          var_name = name.text.toString();
                          var_phone = phone.text.toString();
                          var_type = type.text.toString();
                          jsonAbout = jsonEncode(
                              _controller.document.toDelta().toJson());
                        });
                        Employer().updateEmployer(var_mail, var_name, var_type,
                            var_loc, jsonAbout!, var_phone, urlImg!);
                        setState(() {});
                        toast("Changes Saved",
                            "The changes where done Successfully", context);
                        Navigator.pop(context);
                      } else {
                        toast("Field Empty", "Enter all fields", context);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.black),
                        shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))))),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                "Additional Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Divider(),
              SizedBox(
                height: 25,
              ),
              Wrap(
                spacing: 25,
                children: [
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.black),
                            shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        child: const Text(
                          "Change Password",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.redAccent),
                            shape: WidgetStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        child: const Text(
                          "Delete Account",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
