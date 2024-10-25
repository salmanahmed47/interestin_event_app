// // lib/services/auth_service.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user_model.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Create AppUser object from Firebase User
//   AppUser? _userFromFirebaseUser(User? user, Map<String, dynamic>? userData) {
//     if (user != null && userData != null) {
//       return AppUser.fromMap(userData);
//     } else {
//       return null;
//     }
//   }

//   // Sign up with email and password
//   Future<AppUser?> signUp({
//     required String email,
//     required String password,
//     required String name,
//     required String userType,
//     List<String> interests = const [],
//     String societyName = '',
//   }) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );
//       User user = result.user!;

//       // Send email verification
//       await user.sendEmailVerification();

//       // Create user data in Firestore
//       AppUser appUser = AppUser(
//         uid: user.uid,
//         email: email.trim(),
//         userType: userType,
//         name: name,
//         interests: interests,
//         societyName: societyName,
//       );
//       await _db.collection('users').doc(user.uid).set(appUser.toMap());

//       return appUser;
//     } catch (e) {
//       print('Error in signUp: $e');
//       return null;
//     }
//   }

//   // Sign in with email and password
//   Future<AppUser?> signIn(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );
//       User user = result.user!;

//       if (user.emailVerified) {
//         // Get user data from Firestore
//         DocumentSnapshot userDoc =
//             await _db.collection('users').doc(user.uid).get();
//         return _userFromFirebaseUser(
//             user, userDoc.data() as Map<String, dynamic>?);
//       } else {
//         // Email not verified
//         await _auth.signOut();
//         return null;
//       }
//     } catch (e) {
//       print('Error in signIn: $e');
//       return null;
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Reset password
//   Future<void> resetPassword(String email) async {
//     await _auth.sendPasswordResetEmail(email: email.trim());
//   }

//   // Get current user
//   Future<AppUser?> getCurrentUser() async {
//     User? user = _auth.currentUser;
//     if (user != null && user.emailVerified) {
//       DocumentSnapshot userDoc =
//           await _db.collection('users').doc(user.uid).get();
//       return _userFromFirebaseUser(
//           user, userDoc.data() as Map<String, dynamic>?);
//     } else {
//       return null;
//     }
//   }
// }

// new code
// ==========================================

// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create AppUser object from Firebase User
  AppUser? _userFromFirebaseUser(User? user, Map<String, dynamic>? userData) {
    if (user != null && userData != null) {
      return AppUser.fromMap(userData);
    } else {
      return null;
    }
  }

  // Sign up with email and password
  Future<AppUser?> signUp({
    required String email,
    required String password,
    required String name,
    required String userType,
    List<String> interests = const [],
    String societyName = '',
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User user = result.user!;

      // Send email verification
      await user.sendEmailVerification();

      // Create user data in Firestore
      AppUser appUser = AppUser(
        uid: user.uid,
        email: email.trim(),
        userType: userType,
        name: name,
        interests: interests,
        societyName: societyName,
      );
      await _db.collection('users').doc(user.uid).set(appUser.toMap());

      return appUser;
    } catch (e) {
      print('Error in signUp: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<AppUser?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User user = result.user!;

      if (user.emailVerified) {
        // Get user data from Firestore
        DocumentSnapshot userDoc =
            await _db.collection('users').doc(user.uid).get();
        return _userFromFirebaseUser(
            user, userDoc.data() as Map<String, dynamic>?);
      } else {
        // Email not verified
        await _auth.signOut();
        return null;
      }
    } catch (e) {
      print('Error in signIn: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Get current user (AppUser)
  Future<AppUser?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null && user.emailVerified) {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(user.uid).get();
      return _userFromFirebaseUser(
          user, userDoc.data() as Map<String, dynamic>?);
    } else {
      return null;
    }
  }

  // Get current Firebase User
  User? get currentUser => _auth.currentUser;

  // Reload current user
  Future<void> reloadCurrentUser() async {
    await _auth.currentUser?.reload();
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }
}
