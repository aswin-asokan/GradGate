import 'package:flutter/material.dart';

class Homeemp extends StatefulWidget {
  const Homeemp({super.key});

  @override
  State<Homeemp> createState() => _HomeempState();
}

class _HomeempState extends State<Homeemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employer"),
      ),
    );
  }
}
