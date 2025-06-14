import 'package:flutter/material.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget(
      {super.key,
      required this.icon,
      required this.isSelected,
      required this.text});
  final IconData icon;
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 80,
      width: 200,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          isSelected
              ? BoxShadow(
                  color: Colors.blue.withAlpha(60),
                  spreadRadius: 2,
                  blurRadius: 10, // Stronger blur for selected item
                  offset: const Offset(0, 4), // Shadow position
                )
              : BoxShadow(
                  color: const Color.fromARGB(255, 187, 210, 250).withAlpha(30),
                  spreadRadius: 2,
                  blurRadius: 8, // Lighter blur for non-selected item
                  offset: const Offset(0, 2), // Shadow position
                ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: isSelected ? Colors.white : Colors.black),
          const SizedBox(
            width: 5,
          ),
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
    );
  }
}
