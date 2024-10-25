// lib/screens/students/student_registration_screen.dart
import 'package:flutter/material.dart';
import 'package:interestin_app/services/auth_service.dart';
import 'package:interestin_app/widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../screens/common/email_verification_screen.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  _StudentRegistrationScreenState createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  String error = '';

  // University email domain
  final String universityDomain = 'university.edu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Name',
                onChanged: (val) => name = val,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Enter your name',
              ),
              CustomTextField(
                labelText: 'University Email',
                onChanged: (val) => email = val,
                validator: (val) =>
                    val != null && val.contains('@$universityDomain')
                        ? null
                        : 'Enter a valid university email',
              ),
              CustomTextField(
                labelText: 'Password',
                obscureText: true,
                onChanged: (val) => password = val,
                validator: (val) => val != null && val.length >= 6
                    ? null
                    : 'Enter a password 6+ chars long',
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                obscureText: true,
                onChanged: (val) => confirmPassword = val,
                validator: (val) => val != null && val == password
                    ? null
                    : 'Passwords do not match',
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Register',
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    var user = await _authService.signUp(
                      email: email,
                      password: password,
                      name: name,
                      userType: 'student',
                    );
                    if (user != null) {
                      // Navigate to Email Verification Screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmailVerificationScreen(),
                        ),
                      );
                    } else {
                      setState(() {
                        error = 'Registration failed. Please try again.';
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
              TextButton(
                child: const Text('Already have an account? Log In'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
