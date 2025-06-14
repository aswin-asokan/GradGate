import 'package:flutter/material.dart';
import 'package:gradgate/helper/database_helper.dart';
import 'package:gradgate/shared/extensions/variables.dart';
import 'package:gradgate/shared/widgets/custom_password.dart';
import 'package:gradgate/shared/widgets/toast.dart';

class ChangePasswordDialog extends StatelessWidget {
  final TextEditingController oldPass;
  final TextEditingController newPass;
  final TextEditingController confirmPass;

  const ChangePasswordDialog({
    super.key,
    required this.oldPass,
    required this.newPass,
    required this.confirmPass,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Change Password",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPassword(
              head: "Enter old password",
              hint: "Old Password",
              pass: oldPass,
            ),
            const SizedBox(height: 10),
            CustomPassword(
              head: "Enter new password",
              hint: "New Password",
              pass: newPass,
            ),
            const SizedBox(height: 10),
            CustomPassword(
              head: "Confirm new password",
              hint: "Confirm Password",
              pass: confirmPass,
            ),
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
              backgroundColor: const WidgetStatePropertyAll(Colors.blueAccent),
              shape: WidgetStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            onPressed: () async {
              final dbHelper = DBHelper();

              if (newPass.text != confirmPass.text) {
                toast("Error", "New passwords do not match", context);
                return;
              }

              final isOldPasswordCorrect =
                  await dbHelper.verifyOldPassword(varMail, oldPass.text);

              if (!isOldPasswordCorrect) {
                // ignore: use_build_context_synchronously
                toast("Error", "Old password is incorrect", context);
                return;
              }

              final updated =
                  await dbHelper.updatePassword(varMail, newPass.text);

              if (updated) {
                // ignore: use_build_context_synchronously
                toast("Success", "Password updated successfully", context);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              } else {
                // ignore: use_build_context_synchronously
                toast("Error", "Failed to update password", context);
              }
            },
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
