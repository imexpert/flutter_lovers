import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';
import 'package:flutter_lovers/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context, listen: true);
    var result = await _userModel.signInAnonymous();
    print("Oturum açan kullanıcı " + result.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Lovers"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oturum Açın",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              buttonText: "Gmail İle Giriş Yap",
              textColor: Colors.black87,
              radius: 16,
              onPressed: () {},
              buttonIcon: Image.asset("images/google.png"),
              buttonColor: Colors.white,
            ),
            SocialLoginButton(
              buttonText: "Facebook İle Giriş Yap",
              textColor: Colors.white,
              buttonIcon: Image.asset("images/facebook.png"),
              radius: 16,
              onPressed: () {},
              buttonColor: Color(0xFF334D92),
            ),
            SocialLoginButton(
              buttonText: "E-Mail ve Şifre ile Giriş Yap",
              buttonIcon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
              textColor: Colors.white,
              radius: 16,
              onPressed: () => _misafirGirisi(context),
              buttonColor: Colors.purple,
            ),
            SocialLoginButton(
              buttonText: "Misafir Girişi",
              buttonIcon: Icon(
                Icons.supervised_user_circle,
                size: 32,
                color: Colors.white,
              ),
              textColor: Colors.white,
              radius: 16,
              onPressed: () => _misafirGirisi(context),
              buttonColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
