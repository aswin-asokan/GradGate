import 'package:flutter/material.dart';
import 'package:gradgate/colors.dart';

// ignore: must_be_immutable
class Custpass extends StatefulWidget {
  TextEditingController pass;
  String hint;
  String head;
  Custpass(
      {super.key, required this.head, required this.hint, required this.pass});

  @override
  State<Custpass> createState() => _CustpassState();
}

class _CustpassState extends State<Custpass> {
  bool passObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.head,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
            controller: widget.pass,
            maxLength: null,
            keyboardType: TextInputType.visiblePassword,
            obscureText: passObscure,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              counterText: "",
              fillColor: textField,
              filled: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passObscure = !passObscure;
                    });
                  },
                  icon: Icon(
                      passObscure ? Icons.visibility : Icons.visibility_off)),
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
            )),
      ],
    );
  }
}
