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
  Future<UserModel> signInWithGoogle() {
    return Future.value(UserModel(userID: userID));
  }
}
