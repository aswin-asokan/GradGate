import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gradgate/Student/viewJob.dart';
import 'package:gradgate/colors.dart';
import 'package:toastification/toastification.dart';


Widget customTextField(String hint, String head,
    TextEditingController controller, TextInputType type, var max) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        head,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      TextField(
        controller: controller,
        maxLength: max,
        keyboardType: type,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
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
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    description: Text(desc),
    autoCloseDuration: const Duration(seconds: 5),
  );
}

Widget multilineText(QuillController controller, String head) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        head,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      QuillSimpleToolbar(
        controller: controller,
        configurations:
            const QuillSimpleToolbarConfigurations(showInlineCode: false),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: textField,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: 300, // Set a fixed height
        child: QuillEditor.basic(
          controller: controller,
          configurations: const QuillEditorConfigurations(),
        ),
      ),
    ],
  );
}
Widget jobSearchWidget(
    String date,
    String company,
    String job,
    String link,
    String type,
    String salary,
    String location,
    String jobAbout,
    String jobId,
    Color color,
    BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    width: 350,
    padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 25, right: 25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                child: Text(
                  date,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                company,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      job,overflow: TextOverflow.ellipsis,softWrap: true,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent, // Optional: Set a background color if needed
                      child: ClipOval(
                        child: link == "assets/images/no-profile-picture-15258 (1).png"
                            ? Image.asset(
                                "assets/images/no-profile-picture-15258 (1).png",
                                fit: BoxFit.cover, // Use BoxFit.cover to fill the CircleAvatar
                                width: 200, // Set the width to be double the radius
                                height: 200, // Set the height to be double the radius
                              )
                            : Image.network(
                                link,
                                fit: BoxFit.cover, // Use BoxFit.cover to fill the CircleAvatar
                                width: 200, // Set the width to be double the radius
                                height: 200, // Set the height to be double the radius
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
                child: Text(
                  type,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$$salary/m",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    location,overflow: TextOverflow.ellipsis,softWrap: true
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Viewjob(
                                  jobTitle: job,
                                  jobCompany: company,
                                  jobType: type,
                                  jobLocation: location,
                                  lastDate: date,
                                  imgLink: link,
                                  jobAbout: jobAbout,
                                  jobSalary: salary,
                                  jobId: jobId,
                                )),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(Colors.black),
                        shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))))),
                    child: const Text(
                      "Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        )
      ],
    ),
  );
}


Widget studentReply(String reply) {
  return Container(
    width: 300,
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 249, 187),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.info_outline,
          size: 20,
          color: Colors.redAccent,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "Student Reply: $reply",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ],
    ),
  );
}
