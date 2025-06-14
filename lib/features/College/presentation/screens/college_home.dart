import 'package:flutter/material.dart';
import 'package:gradgate/features/College/presentation/screens/college_profile.dart';
import 'package:gradgate/features/College/presentation/screens/college_dashboard.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class CollegeHome extends StatefulWidget {
  const CollegeHome({super.key});

  @override
  State<CollegeHome> createState() => _HomeempState();
}

class _HomeempState extends State<CollegeHome> {
  List<Widget> pages = [const CollegeDashboard(), const CollegeProfile()];
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
                        color: Colors.blue.withAlpha(60),
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
                  onTap: () async {
                    setState(() {
                      selectedIndex = 1;
                    });
                  })
            ],
            showToggleButton: false,
          ),
          Expanded(child: pages[selectedIndex])
        ],
      ),
    );
  }
}
