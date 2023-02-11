import 'package:flutter/material.dart';

import 'package:onlinediagnostic_nurse/ui/screens/login_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/order_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/memberdetails_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nurse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MemberdetailsScreen(),
    );
  }
}
