import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

      final facebookLogin = FacebookLogin();
      facebookLogin.logOut();

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

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final FacebookLogin _facebookLogin = new FacebookLogin();
      FacebookLoginResult result =
          await _facebookLogin.logIn(['public_profile', 'email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          if (result.accessToken != null) {
            var user = await _firebaseAuth.signInWithCredential(
                FacebookAuthProvider.credential(result.accessToken.token));

            return _userFromFirebase(user.user);
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("facebook login kullanıcı tarafından iptal edildi");
          break;
        case FacebookLoginStatus.error:
          print("facebook login hata." + result.errorMessage);
          break;
      }
    } catch (e) {
      print("facebook login hata." + e.toString());
    }

    return null;
  }
}
