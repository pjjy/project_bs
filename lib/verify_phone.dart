import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;

  VerifyPhone({Key key, @required this.phoneNumber}): super(key: key);
  @override
  _VerifyPhone createState() => _VerifyPhone();
}

class _VerifyPhone extends State<VerifyPhone> {
  Color color = const Color(0xff0084ff);
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  final countryCode = "+63";

  Future<void> verifyPhone(phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      print("success");
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  void initState() {
    print(countryCode+widget.phoneNumber);
//    verifyPhone(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Ionicons.md_arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                        child: Center(
                          child: Text("Please Enter Verification Code",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 0.0),
                        child: Center(
                          child: Text("Please enter the code sent to (+63) ${widget.phoneNumber}",style: TextStyle(color: Colors.black54 ,fontSize: 18.0),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 0.0),
                        child: Center(
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.blueGrey,
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 0.0),
                        child: Center(
                          child: Text("RESEND CODE IN: 12",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54 ,fontSize: 15.0),),
                        ),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                children: <Widget>[

                  Flexible(
                    child: SleekButton(
                      onTap: () async {
//                        Navigator.of(context).push(_checkOut());
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
                          "Verify",
                          style: GoogleFonts.openSans(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
      ),
    );
  }
}

