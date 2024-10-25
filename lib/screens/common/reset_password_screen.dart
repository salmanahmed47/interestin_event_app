// lib/screens/common/reset_password_screen.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
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
              const SizedBox(height: 20),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    await _authService.resetPassword(email);
                    setState(() {
                      message =
                          'A password reset link has been sent to your email.';
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
