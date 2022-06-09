import 'package:flutter/material.dart';
import 'package:my_journal/screens/notelist_screen.dart';
import 'package:my_journal/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SignupScreen(),
    );
  }
}
