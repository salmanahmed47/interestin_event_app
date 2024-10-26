// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/common/onboarding_screen.dart';
import 'screens/common/login_screen.dart';
import 'screens/students/student_home_screen.dart';
import 'screens/society/society_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase working');
  } catch (e) {
    // Handle error
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isLoading = true;
  Widget _defaultHome =
      const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  void initState() {
    super.initState();
    _setupDefaultHome();
  }

  Future<void> _setupDefaultHome() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool seenOnboarding = prefs.getBool('onboarding_complete') ?? false;
    bool seenOnboarding = false;

    if (!seenOnboarding) {
      _defaultHome = const OnboardingScreen();
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        // Fetch userType from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String userType = userDoc.get('userType');
        if (userType == 'student') {
          _defaultHome = const StudentHomeScreen();
        } else if (userType == 'society') {
          _defaultHome = const SocietyHomeScreen();
        } else {
          _defaultHome = const LoginScreen();
        }
      } else {
        _defaultHome = const LoginScreen();
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    } else {
      return MaterialApp(
        title: 'CampusConnect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _defaultHome,
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/student_home': (context) => const StudentHomeScreen(),
          '/society_home': (context) => const SocietyHomeScreen(),
          // Other routes...
        },
      );
    }
  }
}
