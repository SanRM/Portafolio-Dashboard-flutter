import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:portafolio_dashboard_flutter/services/firebase_service.dart';

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      var whiteList = await getCollectionInfo("Lista blanca de usuarios");
      List whiteListDocumento = whiteList[0]['White list'];

      // print('');
      // print("Credenciales que intentaron iniciar sesión: ${userCredential.user?.email}");
      for (var i = 0; i < whiteListDocumento.length; i++) {
        //print(whiteListDocumento[i]);
        if (userCredential.user?.email == whiteListDocumento[i]) {
          return await _firebaseAuth.signInWithCredential(credential);
        }
      }

      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return null;

      //return await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print('Error en el metodo signInWithGoogle: ${error.toString()}');
      return null;
    }
  }

  Future<void> signOutWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (error) {
      //print('Error en el metodo signOutWithGoogle: ${error.toString()}');
    }
  }
}
