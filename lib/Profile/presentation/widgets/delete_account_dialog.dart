import 'package:flutter/material.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_password.dart';
import 'package:gradgate/shared/widgets/toast.dart';

class DeleteAccountDialog extends StatelessWidget {
  final TextEditingController passwordController;

  const DeleteAccountDialog({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Confirm Password",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPassword(
              head: "Enter your password",
              hint: "Password",
              pass: passwordController,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.redAccent),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            onPressed: () async {
              final password = passwordController.text;
              final verified = await DBHelper().verifyOldPassword(
                  varMail, password); // Confirm user's password

              if (verified) {
                await DBHelper().deleteUserByEmail(varMail, userType);

                toast(
                    "Account deleted",
                    "Your account and all data have been removed.",
                    // ignore: use_build_context_synchronously
                    context);
                // ignore: use_build_context_synchronously
                Navigator.popAndPushNamed(context, '/login');
              } else {
                toast(
                    "Password Mismatch!",
                    "Try again!",
                    // ignore: use_build_context_synchronously
                    context);
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
