import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserProfile {
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userImageUrl;

  set setUser(User? user) {
    _userId = user != null ? user.uid : null;
    _userName = user != null ? user.displayName : null;
    _userEmail = user != null ? user.email : null;
    _userImageUrl = user != null ? user.photoURL : null;
  }

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userImageUrl => _userImageUrl;
}
