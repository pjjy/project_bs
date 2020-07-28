import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'create_account.dart';

class UserCart extends StatefulWidget {
  @override
  _UserCart createState() => _UserCart();
}

class _UserCart extends State<UserCart> {

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  List loadEdit;
  List getTenantLimit;
  List lGetAmountPerTenant;
  var isLoading = false;
  var checkOutLoading = true;
  var deviceId;
  Color color = const Color(0xff0084ff);

  Future _getId() async {
    var dId;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      dId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else{
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      dId = androidDeviceInfo.androidId; //
    }
    return dId;
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
            IconButton(
                icon: Icon(Ionicons.ios_search,),
                onPressed: () async {

                }
            ),
          ],
          title: Text(
            "My cart",
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
                  child: FutureBuilder(
                    future: Firestore.instance.collection("user_cart").document(deviceId).collection('cart_items').getDocuments(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData ?
                      Center(child: CircularProgressIndicator()):
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = snapshot.data.documents[index];
                            return GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 7.0,
                                width: MediaQuery.of(context).size.width / 10.0,
                                child: Card(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                                            child: Container(
                                                width: MediaQuery.of(context).size.width / 7.0,
                                                height: MediaQuery.of(context).size.height / 10.0,
                                                decoration: new BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.rectangle,
                                                  image: new DecorationImage(
                                                    image: new NetworkImage(data['imgPath']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            child:Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(15.0, 1.0,  5.0, 1.0),
                                                  child:Text(data['title'], overflow: TextOverflow.clip,
                                                    style: GoogleFonts.openSans(
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize: MediaQuery.of(context).size.width / 28.0),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(15, 1, 5, 5),
                                                  child:Text('100 grams x PCS ${data['quantity']}', overflow: TextOverflow.clip,
                                                    style: GoogleFonts.openSans(
                                                        fontStyle:
                                                        FontStyle.normal,
                                                        fontSize:MediaQuery.of(context).size.width / 30.0),
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                                      child: new Text(
                                                        "₱ ${oCcy.format(data['price'])} ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: MediaQuery.of(context).size.width / 28.0,
                                                          color:color,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  elevation: 0.0,
                                  margin: EdgeInsets.all(3),
                                ),
                              ),
                            );

                          });
                    },
                  ),
                ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
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
                          "Next",
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

