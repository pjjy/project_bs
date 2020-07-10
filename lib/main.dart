import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'home.dart';
import 'item_details.dart';
import 'user_cart.dart';
import 'check_out.dart';
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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: UserCart(),
//      home: ItemDetail(),
      home: MyHomePage(),
//      home:CheckOut(),
//        home:Test(),
    );
  }
}

