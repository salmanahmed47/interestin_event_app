// lib/screens/society/society_registration_screen.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../screens/common/email_verification_screen.dart';

class SocietyRegistrationScreen extends StatefulWidget {
  const SocietyRegistrationScreen({super.key});

  @override
  _SocietyRegistrationScreenState createState() =>
      _SocietyRegistrationScreenState();
}

class _SocietyRegistrationScreenState extends State<SocietyRegistrationScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  String societyName = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Society Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Contact Person Name',
                onChanged: (val) => name = val,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Enter your name',
              ),
              CustomTextField(
                labelText: 'Society Name',
                onChanged: (val) => societyName = val,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Enter society name',
              ),
              CustomTextField(
                labelText: 'Email',
                onChanged: (val) => email = val,
                validator: (val) => val != null && val.contains('@')
                    ? null
                    : 'Enter a valid email',
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
                      userType: 'society',
                      societyName: societyName,
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
