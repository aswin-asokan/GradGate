import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void toast(String head, String desc, BuildContext context) {
  toastification.show(
    context: context,
    style: ToastificationStyle.flatColored,
    title: Text(
      head,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(desc),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
