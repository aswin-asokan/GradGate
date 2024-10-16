import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:gradgate/College/colProfile.dart';
import 'package:gradgate/College/collegeDashboard.dart';
import 'package:gradgate/colors.dart';
import 'package:sidebarx/sidebarx.dart';
>>>>>>> Stashed changes

class Homecoll extends StatefulWidget {
  const Homecoll({super.key});

  @override
  State<Homecoll> createState() => _HomecollState();
}

<<<<<<< Updated upstream
class _HomecollState extends State<Homecoll> {
=======
class _HomeempState extends State<Homecoll> {
  List<Widget> pages = [const Collegedashboard(), const Colprofile()];
  int selectedIndex = 0;
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("College"),
      ),
    );
  }
}
