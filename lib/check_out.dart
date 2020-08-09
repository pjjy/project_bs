import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_account.dart';

class CheckOut extends StatefulWidget {

  @override
  _CheckOut createState() => _CheckOut();
}

class _CheckOut extends State<CheckOut> {

  Color color = const Color(0xff0084ff);



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar:AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Ionicons.md_arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Ionicons.ios_search,),
                onPressed: () async {
                  print("hello");
                }
            ),
          ],
          title: Text(
            "Check out",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: color,
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: ListView(
                    children: <Widget>[
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.0,
                          width: MediaQuery.of(context).size.width / 10.0,
                          child: Card(
                            elevation: 0.0,
                            color: Colors.white,
//                            child: ,
                          ),
                        ),
                      ),
                    ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SleekButton(
                      onTap: () async {
                        Navigator.of(context).push(_checkOut());
                      },
                      style: SleekButtonStyle.flat(
                        color:Colors.transparent,
//                        inverted: false,
                        rounded: false,
                        size: SleekButtonSize.big,
                        context: context,
                      ),
                      child: Center(
                        child: Text(
                          "Total: \₱2,220.00",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: SleekButton(
                      onTap: () async {
                        Navigator.of(context).push(_checkOut());
                      },
                      style: SleekButtonStyle.flat(
                        color:color,
                        inverted: false,
                        rounded: false,
                        size: SleekButtonSize.big,
                        context: context,
                      ),
                      child: Center(
                        child: Text(
                          "Check Out",
                          style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
//      ),
      ),
    );
  }
}

Route _checkOut() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CreateAccount(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.decelerate;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

