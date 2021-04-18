import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/social_login_button.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class EmailveSifreLoginPage extends StatefulWidget {
  @override
  _EmailveSifreLoginPageState createState() => _EmailveSifreLoginPageState();
}

class _EmailveSifreLoginPageState extends State<EmailveSifreLoginPage> {
  String _email, _sifre;
  FormType _formType = FormType.Login;

  String _buttonText, _linkText;

  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserViewModel>(context, listen: false);
    if (_formType == FormType.Login) {
      UserModel girisYapanUser =
          await _userModel.signInWithEmailAndPassword(_email, _sifre);
    } else {
      UserModel kayitYapanUser =
          await _userModel.createUserWithEmailAndPassword(_email, _sifre);
    }
    debugPrint(_email + " " + _sifre);
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız Yok Mu? Kayıt Olun"
        : "Zaten Üye Misiniz? Giriş Yapın";

    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş & Kayıt"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilenEmail) {
                    _email = girilenEmail;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Şifre',
                    labelText: 'Şifre',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (String girilenSifre) {
                    _sifre = girilenSifre;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                SocialLoginButton(
                  buttonText: _buttonText,
                  buttonColor: Theme.of(context).primaryColor,
                  buttonIcon: Icon(Icons.login),
                  radius: 20.0,
                  onPressed: () => _formSubmit(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () => _degistir(),
                  child: Text(_linkText),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
