import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'home.dart';
import 'verify_phone.dart';
import 'create_account.dart';
import 'user_cart.dart';
import 'test.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Boy sugo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//        home:Test(),
//        home:UserCart(),
        home: MyHomePage(),
//        home: CreateAccount(),
    );
  }
}

