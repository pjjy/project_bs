import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_account.dart';
import 'global_vars.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'check_out.dart';
import 'item_details.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserCart extends StatefulWidget {

  @override
  _UserCart createState() => _UserCart();
}

class _UserCart extends State<UserCart> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  List loadEdit;
  List getTenantLimit;
  List lGetAmountPerTenant;
  var isLoading = true;
  var checkOutLoading = true;
  var userExistInCart = false;
  Color color = const Color(0xff0084ff);
  checkIf() async{
//    print(globalDeviceId);
    DocumentSnapshot ds = await Firestore.instance.collection("user_cart").document(globalDeviceId).get();
    if (!mounted) return;
    setState(() {
      userExistInCart = ds.exists;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIf();
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
                icon: Icon(SimpleLineIcons.magnifier,),
                onPressed: () {

                }
            ),
          ],
          title: Text(
            "My cart",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontStyle: FontStyle.normal,
                fontSize: 22.0),
          ),
        ),
        body: isLoading ? Center(child:SpinKitRing(
          color: Colors.blue,
          lineWidth: 5.0,
          size: 40,
        ),): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Visibility(
            visible: userExistInCart == false ? false:true,
            replacement: Expanded(
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                     height: 70,
                     width: 70,
                     child: Image.asset("assets/png/empty-cart.png"),
                   ),
                   SizedBox(
                     height: 15.0,
                   ),
                   Text("Your cart is empty",style: GoogleFonts.openSans(color: Colors.black54, fontStyle: FontStyle.normal, fontSize: 18.0)),
                 ],
                ),
              ),
            ),
            child:Expanded(
              child: Scrollbar(
                child: FutureBuilder(
                  future: Firestore.instance.collection("user_cart").document(globalDeviceId).collection('cart_items').getDocuments(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData ?
                    Center(child:SpinKitRing(
                      color: Colors.blue,
                      lineWidth: 5.0,
                      size: 40,
                    ),):
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(_itemDetails(globalDeviceId,data.documentID,data['imgPath'],data['title'],data['price'],data['priceCompare'],data['description']));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5.0,
                              width: MediaQuery.of(context).size.width / 10.0,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 7.0,
                                            height: MediaQuery.of(context).size.height / 6.0,
                                              child: CachedNetworkImage(
                                                height: 60.0,
                                                imageUrl: data['imgPath'],
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.center,
                                               ),
                                          ),
                                        ),
                                        Expanded(
                                          child:Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(15.0, 1.0,  0.0, 1.0),
                                                child:Text(data['title'], overflow: TextOverflow.clip,
                                                  style: GoogleFonts.openSans(
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 28.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 3.0),
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
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width / 28.0, color:color,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                                                    child:FlatButton(
                                                      disabledColor: Colors.grey,
                                                      child: Text('Remove',style: GoogleFonts.openSans(color: Colors.black45,fontSize: 14.0),),
//                                                          color: Colors.deepOrange,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                      onPressed: (){
//                                                        removeFromCart(loadCartData[index]['d_id']);
                                                      },
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child:Container(
                                                      width: 50.0,
                                                      child: FlatButton(
                                                        disabledColor: Colors.grey,
                                                        child: Text('-',style: GoogleFonts.openSans(color: Colors.black45,fontSize: 14.0),),
//                                                          color: Colors.deepOrange,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                        onPressed: (){
                                                          setState(() {
//                                                            var x = loadCartData[index]['d_quantity'];
//                                                            int d = int.parse(x.toString());
//                                                            loadCartData[index]['d_quantity'] = d-=1;  //code ni boss rene
//                                                            if(d<1){
//                                                              loadCartData[index]['d_quantity']=1;
//                                                            }
//                                                            updateCartQty(loadCartData[index]['d_id'].toString(),loadCartData[index]['d_quantity'].toString());
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:EdgeInsets.fromLTRB(1, 5, 5, 5),
                                                    child:Text('2',style: GoogleFonts.openSans(color: Colors.black45,fontSize: 14.0),),
                                                  ),

                                                  Padding(
                                                    padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child:Container(
                                                      width: 50.0,
                                                      child: FlatButton(
                                                        disabledColor: Colors.grey,
                                                        child: Text('+',style: GoogleFonts.openSans(color: Colors.black45,fontSize: 14.0),),
//                                                          color: Colors.deepOrange,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                        onPressed: (){
                                                          setState(() {
//                                                            var x = loadCartData[index]['d_quantity'];
//                                                            int d = int.parse(x.toString());
//                                                            loadCartData[index]['d_quantity'] = d+=1;   //code ni boss rene
//                                                            updateCartQty(loadCartData[index]['d_id'].toString(),loadCartData[index]['d_quantity'].toString());
                                                          });
//                                                              removeFromCart(loadCartData[index]['d_id']);
                                                        },
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                elevation: 0.0,
                                margin: EdgeInsets.all(2.5),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        Visibility(
         visible: userExistInCart == false ? false:true,
         child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SleekButton(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    print("logout");
//                    Navigator.of(context).push(_checkOut());
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
                      "Total: \₱ 2,220.00",
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
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String status  = prefs.getString('uid');
                    status != null ? Navigator.of(context).push(_checkOut()):
                    Navigator.of(context).push(_createAccount());
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
                          fontSize: 17.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ),

          ],
        ),
//      ),
      ),
    );
  }
}

Route _itemDetails(deviceId,documentID,imgSrc,title,pricing,priceCompare,description) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ItemDetail(deviceId:deviceId,documentID:documentID,imgSrc:imgSrc,title:title,pricing:pricing,priceCompare:priceCompare,description:description),
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

Route _checkOut() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CheckOut(),
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

Route _createAccount() {
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
