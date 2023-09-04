

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {

  String? _uid;
  String? _name;
  String? _email;
  String? _imageUrl;

  set user(User? user){

    _uid = user != null ? user.uid : null;
    _name = user != null ? user.displayName : null;
    _email = user != null ? user.email : null;
    _imageUrl = user != null ? user.photoURL : null;

  }

  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get imageUrl => _imageUrl;

}