// lib/screens/common/email_verification_screen.dart

import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final AuthService _authService = AuthService();
  bool isVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkEmailVerified();
  }

  Future<void> checkEmailVerified() async {
    setState(() {
      isLoading = true;
    });

    // Use the public method to reload the current user
    await _authService.reloadCurrentUser();

    var user = _authService.currentUser;
    if (user != null && user.emailVerified) {
      setState(() {
        isVerified = true;
        isLoading = false;
      });
      // Navigate to appropriate screen based on userType
      AppUser? appUser = await _authService.getCurrentUser();
      if (appUser != null) {
        if (appUser.userType == 'student') {
          // Navigate to Interest Selection Screen
          Navigator.pushReplacementNamed(context, '/student_interests');
        } else if (appUser.userType == 'society') {
          Navigator.pushReplacementNamed(context, '/society_home');
        }
      }
    } else {
      setState(() {
        isVerified = false;
        isLoading = false;
      });
    }
  }

  Future<void> resendVerificationEmail() async {
    // Use the public method to send email verification
    await _authService.sendEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification email sent again.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'A verification link has been sent to your email.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('I have verified my email'),
                    onPressed: () async {
                      await checkEmailVerified();
                    },
                  ),
                  TextButton(
                    onPressed: resendVerificationEmail,
                    child: const Text('Resend Verification Email'),
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () async {
                      await _authService.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
