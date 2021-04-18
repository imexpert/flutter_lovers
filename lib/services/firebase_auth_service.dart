import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> currentUser() async {
    try {
      User user = _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      print("currentUser + " + e.toString());
    }

    return null;
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserModel(userID: user.uid);
  }

  @override
  Future<UserModel> signInAnonymous() async {
    try {
      var result = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(result.user);
    } catch (e) {
      print("signInAnonymous + " + e.toString());
    }

    return null;
  }

  @override
  Future<bool> signOut() async {
    try {
      final googleSign = GoogleSignIn();
      googleSign.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Hata");
      return false;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        var result = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: _googleAuth.accessToken,
                idToken: _googleAuth.idToken));
        return _userFromFirebase(result.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
