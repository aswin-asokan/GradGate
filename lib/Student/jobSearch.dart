import 'package:flutter/material.dart';
import 'package:gradgate/components/widgets.dart';

class Jobsearch extends StatefulWidget {
  const Jobsearch({super.key});

  @override
  State<Jobsearch> createState() => _JobsearchState();
}

class _JobsearchState extends State<Jobsearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: jobSearchWidget(const Color.fromARGB(255, 232, 245, 233)),
    );
  }
}
