import 'package:flutter/material.dart';
import 'package:flutter_lovers/model/user_model.dart';
import 'package:flutter_lovers/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final UserModel userModel;

  HomePage({Key key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          TextButton(
              onPressed: () => _cikisYap(context),
              child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Center(
        child: Text("Hoşgeldiniz... ${userModel.userID.toString()}"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context, listen: true);
    var sonuc = await _userModel.signOut();
    return sonuc;
  }
}
