import 'package:flutter/material.dart';

class Homecoll extends StatefulWidget {
  const Homecoll({super.key});

  @override
  State<Homecoll> createState() => _HomecollState();
}

class _HomecollState extends State<Homecoll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("College"),
      ),
    );
  }
}
