import 'package:flutter_lovers/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<UserModel> signInAnonymous();
  Future<bool> signOut();
}
