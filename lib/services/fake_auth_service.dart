import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "asdasd";
  @override
  Future<UserModel> currentUser() async {
    return Future.value(UserModel(userID: userID));
  }

  @override
  Future<UserModel> signInAnonymous() async {
    return await Future.delayed(
        Duration(seconds: 2), () => UserModel(userID: userID));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return await Future.value(UserModel(userID: "google_user_id_12312"));
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    return await Future.value(UserModel(userID: "facebook_user_id_12312"));
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String sifre) async {
    return await Future.value(UserModel(userID: "created_user_id_12312"));
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String sifre) async {
    return await Future.value(UserModel(userID: "signedin_user_id_12312"));
  }
}
