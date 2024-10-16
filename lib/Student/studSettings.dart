import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/colors.dart';
import 'package:gradgate/components/collSelect.dart';
import 'package:gradgate/components/custPass.dart';
import 'package:gradgate/components/imgPicker.dart';
import 'package:gradgate/components/locationField.dart';
import 'package:gradgate/components/widgets.dart';
import 'package:gradgate/variables.dart';

class Studsettings extends StatefulWidget {
  const Studsettings({super.key});

  @override
  State<Studsettings> createState() => _StudsettingsState();
}

class _StudsettingsState extends State<Studsettings> {
  final QuillController _controller = QuillController.basic();
  TextEditingController oldPass = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    //_controller.document = var_about!;
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
                      child: editProImg(width: width, path: urlImg!)),
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
              collSelect(colleges),
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
                      toast(
                          "Changes saved",
                          "The changes you made have been successfully saved",
                          context);
                      Navigator.pop(context);
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
                height: 25,
              ),
              Wrap(
                spacing: 25,
                children: [
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _showChangePasswordDialog(context);
                        },
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
                        onPressed: () {
                          _showDeleteAccountDialog(context);
                        },
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

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Change Password",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Custpass(
                    head: "Enter old password",
                    hint: "Old Password",
                    pass: oldPass),
                const SizedBox(height: 10),
                Custpass(
                    head: "Enter new password",
                    hint: "New Password",
                    pass: newPass),
                const SizedBox(height: 10),
                Custpass(
                    head: "Confirm new password",
                    hint: "Confirm Password",
                    pass: confirmPass),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.blueAccent),
                    shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))))),
                onPressed: () {
                  // Handle change password logic here
                  toast("Password changed", "Your password has been updated",
                      context);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child:
                    const Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  // Delete Account Confirmation Dialog
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Change Password",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Custpass(
                    head: "Enter your password",
                    hint: "Password",
                    pass: oldPass),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.redAccent),
                    shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))))),
                onPressed: () {
                  // Handle change password logic here
                  toast(
                      "Account deleted",
                      "Your account has been deleted with all its data from our database",
                      context);
                  Navigator.popAndPushNamed(context, '/login');
                },
                child:
                    const Text("Delete", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}
