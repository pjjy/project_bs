import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'verify_phone.dart';
import 'create_account.dart';
import 'user_cart.dart';
import 'test.dart';
import 'check_out.dart';
import 'package:get/get.dart';

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
    return GetMaterialApp(
      title: 'Boy sugo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//        home:HomePage(),
//        home:UserCart(),
        home: MyHomePage(),
//        home: CreateAccount(),
//          home:CheckOut(),
    );
  }
}

