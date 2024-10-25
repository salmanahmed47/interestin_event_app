// lib/screens/common/login_screen.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                validator: (val) => val != null && val.isNotEmpty
                    ? null
                    : 'Enter your password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Log In',
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    AppUser? user = await _authService.signIn(email, password);
                    if (user != null) {
                      // Navigate to appropriate home screen
                      if (user.userType == 'student') {
                        Navigator.pushReplacementNamed(
                            context, '/student_home');
                      } else if (user.userType == 'society') {
                        Navigator.pushReplacementNamed(
                            context, '/society_home');
                      }
                    } else {
                      setState(() {
                        error =
                            'Login failed. Please check your credentials and verify your email.';
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
                child: const Text('Forgot Password?'),
                onPressed: () {
                  Navigator.pushNamed(context, '/reset_password');
                },
              ),
              TextButton(
                child: const Text('Don\'t have an account? Register'),
                onPressed: () {
                  // Option to choose between student and society registration
                  _showRegistrationOptions();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegistrationOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        child: Column(
          children: [
            ListTile(
              title: const Text('Register as Student'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/student_register');
              },
            ),
            ListTile(
              title: const Text('Register as Society'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/society_register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
