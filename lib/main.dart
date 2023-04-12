import 'package:flutter/material.dart';
import 'package:onlinediagnostic_nurse/ui/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://nqgmuqmfbhqqbavijyzq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xZ211cW1mYmhxcWJhdmlqeXpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzgwNzk3NzEsImV4cCI6MTk5MzY1NTc3MX0.RXYg968R0bJAXf4tfRi2TKCM8r_bPLifzV0hjSphXKI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Diagnostic Nurse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black12),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
