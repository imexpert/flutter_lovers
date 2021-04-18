import 'package:flutter_lovers/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel> currentUser();
  Future<UserModel> signInAnonymous();
  Future<bool> signOut();
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signInWithEmailAndPassword(String email, String sifre);
  Future<UserModel> createUserWithEmailAndPassword(String email, String sifre);
}
