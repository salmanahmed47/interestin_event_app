// lib/models/user_model.dart
class AppUser {
  final String uid;
  final String email;
  final String userType; // 'student' or 'society'
  final String name;
  final List<String> interests; // For students
  final String societyName; // For societies

  AppUser({
    required this.uid,
    required this.email,
    required this.userType,
    required this.name,
    this.interests = const [],
    this.societyName = '',
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userType': userType,
      'name': name,
      'interests': interests,
      'societyName': societyName,
    };
  }

  // Create from Firestore Map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      userType: map['userType'],
      name: map['name'],
      interests: List<String>.from(map['interests'] ?? []),
      societyName: map['societyName'] ?? '',
    );
  }
}
