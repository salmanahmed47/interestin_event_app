// lib/screens/students/student_home_screen.dart
import 'package:flutter/material.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
      ),
      body: const Center(
        child: Text('Welcome to the Student Home Screen'),
      ),
    );
  }
}