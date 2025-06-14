import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:gradgate/Profile/presentation/widgets/chage_password_dialog.dart';
import 'package:gradgate/Profile/presentation/widgets/delete_account_dialog.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/widgets/location_autocomplete.dart';
import 'package:gradgate/shared/widgets/toast.dart';
import 'package:gradgate/shared/extensions/variables.dart';

class CollegeSettings extends StatefulWidget {
  const CollegeSettings({super.key});

  @override
  State<CollegeSettings> createState() => _CollegeSettingsState();
}

class _CollegeSettingsState extends State<CollegeSettings> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController(text: varName);
    TextEditingController location = TextEditingController(text: varLocation);
    TextEditingController phone = TextEditingController(text: varPhone);
    TextEditingController mail = TextEditingController(text: varMail);
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
              const Text(
                "Details us",
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
                    onPressed: () async {
                      setState(() {
                        varName = name.text.toString();
                        varPhone = phone.text.toString();
                        varLocation = location.text.toString();
                      });
                      final updated = await DBHelper().updateUserDetails(
                        mail: varMail,
                        updatedFields: {
                          'name': varName,
                          'phone': varPhone,
                          'location': varLocation,
                        },
                        type: 'college',
                      );

                      if (updated) {
                        // ignore: use_build_context_synchronously
                        toast("Success", "Profile updated", context);
                      } else {
                        // ignore: use_build_context_synchronously
                        toast("Error", "Nothing was changed", context);
                      }

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context, true);
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
      builder: (context) => ChangePasswordDialog(
        oldPass: oldPass,
        newPass: newPass,
        confirmPass: confirmPass,
      ),
    );
  }

// Delete Account Confirmation Dialog
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DeleteAccountDialog(
        passwordController: oldPass,
      ),
    );
  }
}
