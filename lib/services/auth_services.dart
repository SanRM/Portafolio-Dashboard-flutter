import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<User?> signInWithGoogle() async {
  try {
    // Inicia sesión con Google Sign-In
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signInSilently();

    if (googleSignInAccount != null) {
      // Obtiene las credenciales de Google
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Obtiene el token de acceso y el token de identificación
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Inicia sesión con Firebase Authentication
      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } else {
      // El usuario canceló el inicio de sesión
      return null;
    }
  } catch (error) {
    print("Error al iniciar sesión con Google: $error");
    return null;
  }
}

