import 'package:flutter/material.dart';

class Homestud extends StatefulWidget {
  const Homestud({super.key});

  @override
  State<Homestud> createState() => _HomestudState();
}

class _HomestudState extends State<Homestud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
      ),
    );
  }
}
