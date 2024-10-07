import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/College/homeColl.dart';
import 'package:gradgate/Employer/homeEmp.dart';
import 'package:gradgate/Profile/colRegUI.dart';
import 'package:gradgate/Profile/empDetailsUI.dart';
import 'package:gradgate/Profile/empRegUI.dart';
import 'package:gradgate/Profile/loginUI.dart';
import 'package:gradgate/Profile/settings.dart';
import 'package:gradgate/Profile/signupUI.dart';
import 'package:gradgate/Profile/studRegUI.dart';
import 'package:gradgate/Student/homeStud.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GradGate',
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => const LoginUI(),
          '/signup': (context) => const Signupui(),
          '/StudentHome': (context) => const Homestud(),
          '/EmployerHome': (context) => const Homeemp(),
          '/CollegeHome': (context) => const Homecoll(),
          '/StudentRegister': (context) => const Studregui(),
          '/CollegeRegister': (context) => const ColregUI(),
          '/EmployerRegister': (context) => const Empregui(),
          '/EmployerDetails': (context) => const EmpDetailsUI(),
          '/Settings': (context) => const Settings()
        },
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const LoginUI());
  }
}
