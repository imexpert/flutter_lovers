import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/landing_page.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("çalıştım");
    return MaterialApp(
      title: 'Flutter Lovers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: ChangeNotifierProvider(
        create: (context) => UserViewModel(),
        child: LandingPage(),
      ),
    );
  }
}
