// lib/screens/students/student_interest_screen.dart

import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

class StudentInterestScreen extends StatefulWidget {
  const StudentInterestScreen({super.key});

  @override
  _StudentInterestScreenState createState() => _StudentInterestScreenState();
}

class _StudentInterestScreenState extends State<StudentInterestScreen> {
  final AuthService _authService = AuthService();
  List<String> interests = [
    'Sports',
    'Music',
    'Art',
    'Technology',
    'Science',
    'Literature',
    'Dance',
    'Theater',
    'Business',
    'Health',
    // Add more interests as needed
  ];
  List<String> selectedInterests = [];

  Future<void> saveInterests() async {
    AppUser? user = await _authService.getCurrentUser();
    if (user != null) {
      // Update the user's interests
      await _authService.updateUserData(user.uid, {
        'interests': selectedInterests,
      });
      // Navigate to Student Home Screen
      Navigator.pushReplacementNamed(context, '/student_home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Interests'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'Choose your interests to personalize event recommendations.'),
          ),
          ...interests.map((interest) {
            return CheckboxListTile(
              title: Text(interest),
              value: selectedInterests.contains(interest),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedInterests.add(interest);
                  } else {
                    selectedInterests.remove(interest);
                  }
                });
              },
            );
          }),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              child: const Text('Continue'),
              onPressed: () async {
                await saveInterests();
              },
            ),
          ),
        ],
      ),
    );
  }
}
