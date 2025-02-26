import 'package:flutter/material.dart';
import 'package:gradgate/College/colProfile.dart';
import 'package:gradgate/College/collegeDashboard.dart';
import 'package:gradgate/colors.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:gradgate/variables.dart';
import 'package:gradgate/Controller/collCon.dart';


class Homecoll extends StatefulWidget {
  const Homecoll({super.key});

  @override
  State<Homecoll> createState() => _HomeempState();
}

class _HomeempState extends State<Homecoll> {
  List<Widget> pages = [const Collegedashboard(), const Colprofile()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    bool extend = true;
    if (width < 800) {
      setState(() {
        extend = false;
      });
    } else {
      setState(() {
        extend = true;
      });
    }
    return Scaffold(
      backgroundColor: mainBg,
      body: Row(
        children: [
          SidebarX(
            headerDivider: width > 800
                ? const Column(
                    children: [
                      Text(
                        "GradGate",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                : const Column(
                    children: [
                      Text(
                        "G",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
            controller: SidebarXController(
                selectedIndex: selectedIndex, extended: extend),
            theme: SidebarXTheme(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                width: 70,
                selectedTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                decoration: BoxDecoration(color: side),
                selectedItemDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 10, // Stronger blur for selected item
                        offset: const Offset(0, 4),
                      )
                    ]),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                iconTheme: const IconThemeData(color: Colors.white)),
            extendedTheme: SidebarXTheme(
                textStyle: const TextStyle(color: Colors.white),
                hoverTextStyle: const TextStyle(color: Colors.white),
                padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                width: 200,
                decoration: BoxDecoration(color: side)),
            items: [
              SidebarXItem(
                  icon: Icons.dashboard_outlined,
                  label: '  Dashboard', 
                  onTap: () => setState(() {
                        selectedIndex = 0;
                      })),
            ],
            footerItems: [
              SidebarXItem(
                  icon: Icons.person_outline,
                  label: '  Profile',
                  onTap: ()async{
                    Map<String, dynamic> empData = await collCont().collDetails();
                   setState(() {
                    var_name = empData['college_name'];
                    var_loc = empData['location'];
                    var_phone = empData['phone'];
                        selectedIndex = 1;
                      });
                      }),
            ],
            showToggleButton: false,
          ),
          Expanded(child: pages[selectedIndex])
        ],
      ),
    );
  }
}
