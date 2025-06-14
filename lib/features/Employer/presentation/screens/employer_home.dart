import 'package:flutter/material.dart';
import 'package:gradgate/features/Employer/presentation/screens/employer_dashboard.dart';
import 'package:gradgate/Profile/presentation/screens/profile.dart';
import 'package:gradgate/features/Employer/presentation/screens/job_post.dart';
import 'package:gradgate/Profile/presentation/screens/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class EmployerHome extends StatefulWidget {
  const EmployerHome({super.key});

  @override
  State<EmployerHome> createState() => _EmployerHomeState();
}

class _EmployerHomeState extends State<EmployerHome> {
  List<Widget> pages = [
    const EmployerDashboard(),
    const JobPost(),
    const Profile()
  ];
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
              SidebarXItem(
                  icon: Icons.work_outline_outlined,
                  label: '  Post Job',
                  onTap: () => setState(() {
                        selectedIndex = 1;
                      })),
            ],
            footerItems: [
              SidebarXItem(
                  icon: Icons.person_outline,
                  label: '  Profile',
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
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
