import 'package:flutter/cupertino.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/auth_base.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  UserModel _user;
  String emailHataMesaj, sifreHataMesaj;

  UserModel get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodel => currentUser Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInAnonymous() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymous();
      return _user;
    } catch (e) {
      debugPrint("Viewmodel => currentUser Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodel => currentUser Hata : " + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("Viewmodel => currentUser Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithFacebook();
      return _user;
    } catch (e) {
      debugPrint("Viewmodel => currentUser Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      String email, String sifre) async {
    try {
      if (_emailSifreControl(email, sifre)) {
        state = ViewState.Busy;
        _user =
            await _userRepository.createUserWithEmailAndPassword(email, sifre);
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(
          "Viewmodel => createUserWithEmailAndPassword Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String sifre) async {
    try {
      if (_emailSifreControl(email, sifre)) {
        state = ViewState.Busy;
        _user = await _userRepository.signInWithEmailAndPassword(email, sifre);
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(
          "Viewmodel => createUserWithEmailAndPassword Hata : " + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailSifreControl(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifreHataMesaj = "??ifre En az 6 karakter olmal??d??r";
      sonuc = false;
    } else {
      sifreHataMesaj = null;
    }

    if (!email.contains("@")) {
      emailHataMesaj = "Ge??ersiz Email adresi";
      sonuc = false;
    } else {
      emailHataMesaj = null;
    }

    return sonuc;
  }
}
