import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserProfile {
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userImageUrl;

  set setUser(User? user) {
    _userId = user?.uid;
    _userName = user?.displayName;
    _userEmail = user?.email;
    _userImageUrl = user?.photoURL;
  }

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userImageUrl => _userImageUrl;
}
