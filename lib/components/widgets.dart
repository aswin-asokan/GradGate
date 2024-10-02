import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';
import 'package:toastification/toastification.dart';

Widget customTextField(String hint, String head,
    TextEditingController controller, TextInputType type, var max) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        head,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: controller,
        maxLength: max,
        keyboardType: type,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          counterText: "",
          fillColor: textField,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textField),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textField),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textField),
          ),
        ),
      ),
    ],
  );
}

Widget userType(IconData icon, String text, bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    height: 80,
    width: 200,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: isSelected ? Colors.white : Colors.black),
        Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black, // Change text color if selected
          ),
        )
      ],
    ),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.transparent,
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        isSelected
            ? BoxShadow(
                color: Colors.blue.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 10, // Stronger blur for selected item
                offset: const Offset(0, 4), // Shadow position
              )
            : BoxShadow(
                color:
                    const Color.fromARGB(255, 187, 210, 250).withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8, // Lighter blur for non-selected item
                offset: const Offset(0, 2), // Shadow position
              ),
      ],
    ),
  );
}

void toast(String head, String desc, BuildContext context) {
  toastification.show(
    context: context, // optional if you use ToastificationWrapper
    style: ToastificationStyle.flatColored,
    title: Text(
      head,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(desc),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
