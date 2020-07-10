import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
class CheckOut extends StatefulWidget {
  @override
  _CheckOut createState() => _CheckOut();
}

class _CheckOut extends State<CheckOut> {
  var isLoading = false;
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
          elevation: 1.0,
          iconTheme: new IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Ionicons.ios_arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Badge(
              showBadge: true,
              elevation: 5.0,
              position: BadgePosition.topRight(top: 5, right: 5),
              badgeColor: Colors.green,
              badgeContent: Text('3'),
              child:  IconButton(
                  icon: Icon(Ionicons.ios_cart,),
                  onPressed: () async {

                  }
              ),
            ),
            IconButton(
                icon: Icon(Ionicons.ios_search,),
                onPressed: () async {

                }
            ),
          ],
          title: Text(
            "Check out",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.green.withOpacity(0.8),
                fontStyle: FontStyle.normal,
                fontSize: 18.0),
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child:Scrollbar(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 25.0),
                      child: Container(
                        height: 60.0,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
//                              color: Colors.red,
                              blurRadius:
                              0.0, // has the effect of softening the shadow
                              spreadRadius:
                              0.0, // has the effect of extending the shadow
                              offset: Offset(
                                0.0, // horizontal, move right 10
                                0.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: SignInButton(
                          Buttons.Google,
                          text: "Order with google",
                          onPressed: () {

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                      child: new Text(
                        "Name",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        textInputAction: TextInputAction.done,
                        cursorColor:Colors.blueGrey,
//                        controller: _usernameLogIn,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                        ),
//                        onFieldSubmitted: (String value) {
//                          FocusScope.of(context).requestFocus(textSecondFocusNode);
//                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                      child: new Text(
                        "Phone number",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.blueGrey,
//                        controller: _passwordLogIn,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                        ),
//                        onFieldSubmitted: (String value) {
//                          FocusScope.of(context).requestFocus(textSecondFocusNode);
//                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                      child: new Text(
                        "Address",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.blueGrey,
//                        controller: _passwordLogIn,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey,
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                        ),
//                        onFieldSubmitted: (String value) {
//                          FocusScope.of(context).requestFocus(textSecondFocusNode);
//                        },
                      ),
                    ),
                    Padding(
                        padding:
                        EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 25.0),
//                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: SleekButton(
                          onTap: () {
//                            _signInCheck();
                          },
                          style: SleekButtonStyle.flat(
                            color: Colors.green,
                            inverted: false,
                            rounded: false,
                            size: SleekButtonSize.big,
                            context: context,
                          ),
                          child: Center(
                            child: Text(
                              "Place order",
                              style: GoogleFonts.openSans(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}