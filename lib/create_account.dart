import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'user_cart.dart';
import 'verify_phone.dart';
import 'db_helper.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  var deviceId;
  final db = ProjectBs();
  final _phoneNumber = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _address = TextEditingController();
  final countryCode = "+63";
  Color color = const Color(0xff0084ff);
  var _formKey = GlobalKey<FormState>();
  var validate;

  Future _getId() async {
    var dId;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      dId = iosDeviceInfo.identifierForVendor;
    } else{
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      dId = androidDeviceInfo.androidId;
    }
    return dId;
  }


  String validateNumber(String value){
      if (value.isEmpty) {
        return 'Please enter number';
      }if(validate == true){
        return "already";
      }
      return null;

    }



  addPhoneNumber(phoneNumber) async{



      var exist = await db.checkPhoneNumber(phoneNumber);
      if(exist == true){
        validate = true;
          print(validate);
      }
      if(exist == false){
        validate = false;
        Navigator.of(context).push(_verifyPhone(_phoneNumber.text));
        await db.addPhoneNumber(phoneNumber);
      }
  }

   test(){

    if(_formKey.currentState.validate()){
      print("naay sud");
//      setState(() {
        addPhoneNumber(countryCode+_phoneNumber.text);
//      });
    }
  }

  void _get1() async{
    var q = await _getId();
    setState(() {
      deviceId = q;
    });
  }

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
    _get1();
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
            icon: Icon(Ionicons.md_arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("user_cart").document(deviceId).collection('cart_items').snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData ?
                Center(
                  child: Badge(
                    animationType: BadgeAnimationType.fade,
                    position: BadgePosition.topRight(top: 5, right: 5),
                    badgeColor:color,
                    badgeContent: Text('0',style: TextStyle(color: Colors.white,),),
                    child:  IconButton(
                        icon: Icon(Ionicons.ios_cart,),
                        onPressed: () {
                          Navigator.of(context).push(_viewCart());
                        }
                    ),
                  ),
                ):
                Badge(
                  animationType: BadgeAnimationType.fade,
                  position: BadgePosition.topRight(top: 5, right: 5),
                  badgeColor:color,
                  badgeContent: Text('${snapshot.data.documents.length}',style: TextStyle(color: Colors.white,),),
                  child:  IconButton(
                      icon: Icon(Ionicons.ios_cart,),
                      onPressed:(){
                         Navigator.of(context).push(_viewCart());
                      }
                  ),
                );
              },
            ),
            IconButton(
                icon: Icon(Ionicons.ios_search,),
                onPressed:() async {

                }
            ),
          ],
          title: Text(
            "Account",
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
            Form(
             key:_formKey,
             child:Expanded(
              child:Scrollbar(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
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
                        controller: _name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                      child: new Text(
                        "Password",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        cursorColor:Colors.blueGrey,
                        controller: _password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                      child: new Text(
                        "Phone number",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: new TextFormField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters:[BlacklistingTextInputFormatter(new RegExp('[.-]'))],
                              cursorColor:Colors.blueGrey,
                              controller: _phoneNumber,
                              validator: validateNumber,
                              decoration: InputDecoration(
                                prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+63',style: TextStyle(fontSize: 16.0),)),
                                counterText: "",
                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.withOpacity(0.8),
                                      width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(3.0)),
                              ),
//                            focusNode: textSecondFocusNode,
                            ),
                          ),
                        ],
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
                        controller: _address,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter exact address';
                          }
                          return null;
                        },
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
                  ],
                ),
              ),
             ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 1.0),
              child: Center(
                child: Text(
                  "By signing up, you agree to our",
                  style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal, fontSize: 13.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 1.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Text(
                    "Terms & Conditions and Privacy",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: SleekButton(
                  onTap: (){


                    test();



//
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
                        "Agree & Continue",
                        style: GoogleFonts.openSans(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

Route _viewCart() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => UserCart(),
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

Route _verifyPhone(phoneNumber) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => VerifyPhone(phoneNumber:phoneNumber),
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