import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradgate/features/College/presentation/screens/college_settings.dart';
import 'package:gradgate/features/College/presentation/screens/college_home.dart';
import 'package:gradgate/features/Employer/presentation/screens/employer_home.dart';
import 'package:gradgate/features/College/presentation/screens/college_registration.dart';
import 'package:gradgate/features/Employer/presentation/screens/employer_details_ui.dart';
import 'package:gradgate/features/Employer/presentation/screens/employer_register_ui.dart';
import 'package:gradgate/Profile/presentation/screens/login_ui.dart';
import 'package:gradgate/Profile/presentation/screens/signup_ui.dart';
import 'package:gradgate/features/Student/presentation/screens/stud_registration_ui.dart';
import 'package:gradgate/features/Student/presentation/screens/student_details_ui.dart';
import 'package:gradgate/features/Student/presentation/screens/student_home.dart';
import 'package:gradgate/Profile/presentation/screens/settings.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    // Set the default factory for sqflite_common to use the ffi implementation
    databaseFactory = databaseFactoryFfi;
  }
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
          '/signup': (context) => const SignupUi(),
          '/StudentHome': (context) => const StudentHome(),
          '/EmployerHome': (context) => const EmployerHome(),
          '/CollegeHome': (context) => const CollegeHome(),
          '/StudentRegister': (context) => const StudRegistrationUi(),
          '/StudentDetails': (context) => const StudentDetailsUi(),
          '/CollegeRegister': (context) => const CollegeRegistration(),
          '/EmployerRegister': (context) => const EmployerRegisterUi(),
          '/EmployerDetails': (context) => const EmployerDetailsUi(),
          '/colSettings': (context) => const CollegeSettings(),
          '/Settings': (context) => const Settings()
        },
        localizationsDelegates: const [
          FlutterQuillLocalizations.delegate,
        ],
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: const LoginUI());
  }
}
