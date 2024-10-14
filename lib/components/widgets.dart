import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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

Widget Type(IconData icon, String text, bool isSelected) {
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

Widget multilineText(QuillController _controller, String head) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        head,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      QuillSimpleToolbar(
        controller: _controller,
        configurations:
            const QuillSimpleToolbarConfigurations(showInlineCode: false),
      ),
      const SizedBox(height: 10),
      Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: textField,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: 300, // Set a fixed height
        child: QuillEditor.basic(
          controller: _controller,
          configurations: const QuillEditorConfigurations(),
        ),
      ),
    ],
  );
}

class SalaryFilter extends StatefulWidget {
  const SalaryFilter({super.key});

  @override
  State<SalaryFilter> createState() => _SalaryFilterState();
}

class _SalaryFilterState extends State<SalaryFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 40000);
  @override
  Widget build(BuildContext context) {
    int minimum = _currentRangeValues.start.round();
    int maximum = _currentRangeValues.end.round();

    return Container(
      height: 200,
      width: 500,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: side, // Replace 'side' with your actual color
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Salary Range",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          RangeSlider(
            values: _currentRangeValues,
            max: 1000000,
            divisions:
                100, // Change divisions to a reasonable number for salaries
            labels: RangeLabels(
              minimum.toString(),
              maximum.toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          // Displaying the selected salary range
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Minimum: \₹ ${minimum.toString()}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Maximum: \₹ ${maximum.toString()}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
