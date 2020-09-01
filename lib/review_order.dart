import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_account.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewOrder extends StatefulWidget {
  @override
  _ReviewOrder createState() => _ReviewOrder();
}

class _ReviewOrder extends State<ReviewOrder> {
  Color color = const Color(0xff0084ff);
  String phoneNumber="";
  String specialInstruction = "";
  void detectLastDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phoneNumber');
      specialInstruction = prefs.getString('specialInstruction');
    });
  }

  @override
  void initState() {
    super.initState();
    detectLastDetails();
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
            icon: Icon(Ionicons.md_close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(SimpleLineIcons.magnifier,),
                onPressed: () async {
                  print("hello");
                }
            ),
          ],
          title: Text(
            "Review order",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontStyle: FontStyle.normal,
                fontSize: 22.0),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 7.0,
                      width: MediaQuery.of(context).size.width / 10.0,
                      child:Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15.0, 1.0,  0.0, 1.0),
                                        child:  Container(
                                          height: 25.0,
                                          width: 25.0,
                                          child:SvgPicture.asset('assets/svg/house.svg'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                        child:Text('Delivery Address',
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context).size.width / 28.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child:  Padding(
                                      padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                      child:Text('Del Carmen Del Carmen  Del Carmen  Del Carmen  Del Carmen  Del Carmen   Del Carmen  Del Carmen Del Carmen Este, Balilihan,Bahol ', overflow: TextOverflow.fade,
                                        style: GoogleFonts.openSans(
                                            color: Colors.black54,
                                            fontStyle: FontStyle.normal,
                                            fontSize: MediaQuery.of(context).size.width / 30.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),




                          ],
                        ),

                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height / 7.0,
                      width: MediaQuery.of(context).size.width / 10.0,
                      child:Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15.0, 1.0,  0.0, 1.0),
                                        child:  Container(
                                          height: 25.0,
                                          width: 25.0,
                                          child:SvgPicture.asset('assets/svg/pay.svg'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                        child:Text('Payment method',
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context).size.width / 28.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                          child:Text('Cash on delivery ', overflow: TextOverflow.fade,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black54,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context).size.width / 30.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                          ],
                        ),

                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height / 7.0,
                      width: MediaQuery.of(context).size.width / 10.0,
                      child:Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15.0, 1.0,  0.0, 1.0),
                                        child:  Container(
                                          height: 25.0,
                                          width: 25.0,
                                          child:SvgPicture.asset('assets/svg/contact.svg'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                        child:Text('Phone number',
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context).size.width / 28.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                          child:Text(phoneNumber, overflow: TextOverflow.fade,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black54,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context).size.width / 30.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height / 7.0,
                      width: MediaQuery.of(context).size.width / 10.0,
                      child:Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(15.0, 1.0,  0.0, 1.0),
                                        child:  Container(
                                          height: 25.0,
                                          width: 25.0,
                                          child:SvgPicture.asset('assets/svg/strategy.svg'),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                        child:Text('Special instructions',
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context).size.width / 28.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                          child:Text(specialInstruction, overflow: TextOverflow.fade,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black54,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context).size.width / 30.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),




                          ],
                        ),

                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height / 2.0,
                      width: MediaQuery.of(context).size.width / 10.0,
                      child:Card(
                        elevation: 0.0,
                        color: Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                        child:Text('Charges & delivery time',
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: MediaQuery.of(context).size.width / 28.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Expected Date',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('Dec 31,2020', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Expected Time',
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('11:00 AM - 12:00 PM', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(

                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Sub total',
                                                style: GoogleFonts.openSans(

                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(), //
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('2000.00', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(

                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Discount',
                                                style: GoogleFonts.openSans(

                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(), //

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('10%', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Delivery fee',
                                                style: GoogleFonts.openSans(

                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(), //
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 10.0),
                                              child:Text('Free', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: color,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('30.00', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    decoration: TextDecoration.lineThrough,
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                              child:Text('Total',
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                              child:Text('12,202.00', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 27.0),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: SleekButton(
                  onTap: (){

                  },
                  style: SleekButtonStyle.flat(
                    color: color,
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
                          fontSize: 17.0),
                    ),
                  ),
                )
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

