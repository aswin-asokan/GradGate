import 'package:flutter/material.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';

class StudentCollege extends StatelessWidget {
  const StudentCollege({super.key, required this.company, required this.title});
  final String title;
  final String company;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: secBg, // Assuming secBg is a defined color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Wrap title in Expanded to prevent overflow
          Expanded(
            child: Text(
              title,
              softWrap: true,
              maxLines: 1, // Limit to 1 line, adjust based on your preference
              overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
              width: 10), // Add some spacing between title and company
          // Wrap company in Expanded to prevent overflow
          Expanded(
            child: Text(
              company,
              softWrap: true,
              maxLines: 1, // Limit to 1 line, adjust based on your preference
              overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
              textAlign: TextAlign.right, // Align company text to the right
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
