import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/College/homeColl.dart';
import 'package:gradgate/Employer/homeEmp.dart';
import 'package:gradgate/Profile/colReg.dart';
import 'package:gradgate/Profile/empDetails.dart';
import 'package:gradgate/Profile/empReg.dart';
import 'package:gradgate/Profile/login.dart';
import 'package:gradgate/Profile/signup.dart';
import 'package:gradgate/Profile/studReg.dart';
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
          '/login': (context) => const Login(),
          '/signup': (context) => const Signup(),
          '/StudentHome': (context) => const Homestud(),
          '/EmployerHome': (context) => const Homeemp(),
          '/CollegeHome': (context) => const Homecoll(),
          '/StudentRegister': (context) => const Studreg(),
          '/CollegeRegister': (context) => const Colreg(),
          '/EmployerRegister': (context) => const Empreg(),
          '/EmployerDetails': (context) => const Empdetails(),
        },
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const Empdetails());
  }
}
