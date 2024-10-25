// lib/screens/society/society_home_screen.dart
import 'package:flutter/material.dart';

class SocietyHomeScreen extends StatelessWidget {
  const SocietyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Society Home'),
      ),
      body: const Center(
        child: Text('Welcome to the Society Home Screen'),
      ),
    );
  }
}
