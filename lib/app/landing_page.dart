import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/home_page.dart';
import 'package:flutter_lovers/app/sign_in/sign_in_page.dart';
import 'package:flutter_lovers/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context, listen: true);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(userModel: _userModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
