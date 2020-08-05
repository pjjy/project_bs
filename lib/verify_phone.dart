//import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/material.dart';
//import 'package:sleek_button/sleek_button.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'dart:async';
//import 'package:countdown_flutter/countdown_flutter.dart';
//import 'package:back_button_interceptor/back_button_interceptor.dart';
//import 'db_helper.dart';
//
//class VerifyPhone extends StatefulWidget {
//  final String phoneNumber;
//
//  VerifyPhone({Key key, @required this.phoneNumber}): super(key: key);
//  @override
//  _VerifyPhone createState() => _VerifyPhone();
//}
//
//class _VerifyPhone extends State<VerifyPhone> {
//  final db = ProjectBs();
//  Color color = const Color(0xff0084ff);
//  String phoneNo, verificationId;
//  final countryCode = "+63";
//  final smsCode = TextEditingController();
//
//
//  Future<void> signInWithOTP(smsCode, verId) async{
//
//       AuthCredential authId = PhoneAuthProvider.getCredential(
//        verificationId: verId,
//        smsCode: smsCode);
//
//      await FirebaseAuth.instance.signInWithCredential(authId).then((user) async{
//        print("correct code");
//        await db.verifyNumber(countryCode+widget.phoneNumber);
//      }).catchError((e){
//        print("wrong code");
//      });
//  }
//
//  Future<void> verifyPhone(phoneNumber) async {
//    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//
//    };
//
//    final PhoneVerificationFailed verificationFailed =
//        (AuthException authException) {
//
//    };
//
//    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//      this.verificationId = verId;
//    };
//
//    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
//      this.verificationId = verId;
//    };
//
//    await FirebaseAuth.instance.verifyPhoneNumber(
//        phoneNumber: phoneNumber,
//        timeout: const Duration(seconds: 30),
//        verificationCompleted: verified,
//        verificationFailed: verificationFailed,
//        codeSent: smsSent,
//        codeAutoRetrievalTimeout: autoTimeout
//    );
//  }
//
//  @override
//  void initState() {
//    verifyPhone(countryCode+widget.phoneNumber);
//    BackButtonInterceptor.add(myInterceptor);
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    BackButtonInterceptor.remove(myInterceptor);
//    super.dispose();
//  }
//
//  bool myInterceptor(bool stopDefaultButtonEvent) {
//    return true;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//
//              Expanded(
//                child: ListView(
//                  physics: NeverScrollableScrollPhysics(),
//                  children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
//                        child: Center(
//                          child: Text("Please Enter Verification Code",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 0.0),
//                        child: Center(
//                          child: Text("Please enter the code sent to ($countryCode) ${widget.phoneNumber}",style: TextStyle(color: Colors.black54 ,fontSize: 18.0),),
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 0.0),
//                        child: Center(
//                          child: TextFormField(
//                            textInputAction: TextInputAction.done,
//                            keyboardType: TextInputType.number,
//                            cursorColor: Colors.blueGrey,
//                            controller: smsCode,
//                            decoration: InputDecoration(
//                              contentPadding:
//                              EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide: BorderSide(
//                                    color: Colors.blueGrey,
//                                    width: 2.0),
//                              ),
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(3.0)),
//                            ),
//                          ),
//                        ),
//                      ),
//                        CountdownFormatted(
//                          duration: Duration(seconds: 30),
//                          onFinish: () async{
//                            //delete number
//                            await db.deleteIfTimesUp(countryCode+widget.phoneNumber);
//                            Navigator.of(context).pop();
//                          },
//                          builder: (BuildContext ctx, String remaining) {
//                            return Padding(
//                              padding: EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 0.0),
//                              child: Center(
//                                child: Text("TIME OUT: $remaining",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54 ,fontSize: 15.0),),
//                              ),
//                            );
//                          },
//                        ),
//                  ],
//                ),
//              ),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//              child: Row(
//                children: <Widget>[
//                  Flexible(
//                    child: SleekButton(
//                      onTap: () async {
//                        signInWithOTP(smsCode.text, verificationId);
//                      },
//                      style: SleekButtonStyle.flat(
//                        color:color,
//                        inverted: false,
//                        rounded: false,
//                        size: SleekButtonSize.big,
//                        context: context,
//                      ),
//                      child: Center(
//                        child: Text(
//                          "Verify",
//                          style: GoogleFonts.openSans(
//                              fontStyle: FontStyle.normal,
//                              fontWeight: FontWeight.bold,
//                              fontSize: 15.0),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//
//          ],
//      ),
//    );
//  }
//}
//
