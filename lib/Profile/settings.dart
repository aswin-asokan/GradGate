import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/imgPicker.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final QuillController _controller = QuillController(
      document: var_aboutJ,
      selection: const TextSelection(baseOffset: 0, extentOffset: 0),
      readOnly: true);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    _controller.document = var_aboutJ;
    TextEditingController name = TextEditingController(text: var_name);
    TextEditingController location = TextEditingController(text: var_loc);
    TextEditingController type = TextEditingController(text: var_type);
    TextEditingController phone = TextEditingController(text: var_phone);
    TextEditingController mail = TextEditingController(text: var_mail);
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
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
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
                      child: editProImg(width: width, path: urlImg)),
                  Positioned(
                      left: 20,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 30,
                          )))
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              const SizedBox(
                height: 10,
              ),
              LocationAutocomplete(locationController: location),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: type,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              QuillSimpleToolbar(
                controller: _controller,
                configurations: const QuillSimpleToolbarConfigurations(),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: QuillEditor.basic(
                  controller: _controller,
                  configurations:
                      const QuillEditorConfigurations(scrollable: false),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Contact us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              TextField(
                controller: phone,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: mail,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.grey,
                    )),
              ),
              const SizedBox(
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
                        });

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
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Additional Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 25,
                runSpacing: 25,
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
