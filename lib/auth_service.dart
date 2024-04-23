import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signInGoogle() async {
    final GoogleSignInAccount? google_user= await GoogleSignIn().signIn();

    final GoogleSignInAuthentication google_auth = await google_user!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: google_auth.accessToken,
      idToken: google_auth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}