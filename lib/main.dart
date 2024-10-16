import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/College/colSettings.dart';
import 'package:gradgate/College/homeColl.dart';
import 'package:gradgate/Employer/homeEmp.dart';
import 'package:gradgate/College/colRegUI.dart';
import 'package:gradgate/Employer/empDetailsUI.dart';
import 'package:gradgate/Employer/empRegUI.dart';
import 'package:gradgate/Profile/loginUI.dart';
import 'package:gradgate/Profile/settings.dart';
import 'package:gradgate/Profile/signupUI.dart';
import 'package:gradgate/Student/studDetails.dart';
import 'package:gradgate/Student/studDetailsUI.dart';
import 'package:gradgate/Student/studRegUI.dart';
import 'package:gradgate/Student/homeStud.dart';
import 'package:gradgate/Student/studSettings.dart';
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
          '/Settings': (context) => const Settings(),
          '/colSettings': (context) => const Colsettings(),
          '/studSettings': (context) => const Studsettings()
        },
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const Homestud());
  }
}
