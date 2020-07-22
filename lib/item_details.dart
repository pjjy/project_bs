import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'db_helper.dart';
import 'user_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetail extends StatefulWidget {
  final String deviceId;
  final String documentID;
  final String imgSrc;
  final String title;
  final int pricing;
  final int priceCompare;
  final String description;
  ItemDetail({Key key, @required this.deviceId, this.documentID,this.imgSrc,this.title,this.pricing,this.priceCompare,this.description}): super(key: key);
  @override
  _ItemDetail createState() => _ItemDetail();
}

class _ItemDetail extends State<ItemDetail>  {
  final db = ProjectBs();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final itemCount = TextEditingController();
  Color color = const Color(0xff0084ff);




  addToCart(deviceId,documentID,itemCount,pricing,title,description,imgSrc)
  {
    db.addToCart(deviceId,documentID,itemCount,pricing,title,description,imgSrc);
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog (
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
          contentPadding: EdgeInsets.symmetric(horizontal:1.0, vertical: 20.0),
          title:Row(
            children: <Widget>[
              Text('Success!',style:TextStyle(fontSize: 18.0),),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child:Center(child:Text("Successfully added to cart")),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done',style: TextStyle(color:color.withOpacity(0.8),),),
              onPressed: () async{
                Navigator.of(context).pop();
                Navigator.of(context).pop();
//                                          await db.checkOut(1);
              },
            ),
          ],
        );
      },
    );
  }




  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(Ionicons.md_arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("user_cart").document(widget.deviceId).collection('cart_items').snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData ?
                  Center(
                      child: Badge(
                        animationType: BadgeAnimationType.fade,
                        position: BadgePosition.topRight(top: 5, right: 5),
                        badgeColor: color,
                        badgeContent: Text('0',style: TextStyle(color: Colors.white,),),
                        child:  IconButton(
                            icon: Icon(Ionicons.ios_cart,),
                            onPressed:(){
                              Navigator.of(context).push(_viewCart());
                            }
                        ),
                      ),
                  ):
                  Badge(
                    animationType: BadgeAnimationType.fade,
                    position: BadgePosition.topRight(top: 5, right: 5),
                    badgeColor: color,
                    badgeContent: Text('${snapshot.data.documents.length}',style: TextStyle(color: Colors.white,),),
                    child:  IconButton(
                        icon: Icon(Ionicons.ios_cart,),
                        onPressed:() {
                          Navigator.of(context).push(_viewCart());
                        }
                    ),
                  );
                },
              ),

              IconButton(
                  icon: Icon(Ionicons.ios_search,),
                  onPressed: () async {

                  }
              ),
            ],
            brightness: Brightness.light,
            expandedHeight: 310.0,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 0.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(widget.imgSrc,fit: BoxFit.scaleDown,
                )
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){

                          },
                          child: new Text('-',style: TextStyle(fontSize: 25,color: Colors.black,),),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                        ),
                        Container(
                          width: 80,
                          child: StreamBuilder<DocumentSnapshot>(
                                stream: Firestore.instance.collection('user_cart').document(widget.deviceId).collection('cart_items').document(widget.documentID).snapshots(),
                                builder: (context, snapshot) {
                                if (!snapshot.hasData || !snapshot.data.exists) {
                                  itemCount.text = "1";
                                  return TextField(
                                    onChanged: (text) {
                                      //itemCount.clear();
                                    },
                                    style: new TextStyle(
                                        color: color,
                                        //fontSize: 18.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                    controller: itemCount,
                                    maxLength: 3,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[.-]'))],
                                    cursorColor: Colors.blueGrey.withOpacity(0.8),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding: EdgeInsets.all(20.0),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.8), width: 2.0),
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
                                    ),
                                  );
                                } else {
                                  Map<String, dynamic> documentFields = snapshot.data.data;
                                  itemCount.text = documentFields['quantity'].toString();
                                      return TextField(
                                        onChanged: (text) {
                                          //itemCount.clear();
                                        },
                                        style: new TextStyle(
                                            color: color,
                                            //fontSize: 18.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                        controller: itemCount,
                                        maxLength: 3,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[.-]'))],
                                        cursorColor: Colors.blueGrey.withOpacity(0.8),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.all(20.0),
                                          focusedBorder:OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.8), width: 2.0),
                                          ),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(3.0)),
                                        ),
                                  );
                                }
                          }),
//
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                        ),
                        FlatButton(
                          onPressed: (){
                          },
                          child: new Text('+',style: TextStyle(fontSize: 25,color: Colors.black,),),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                      child:SleekButton(
                        onTap: () {
                          addToCart(widget.deviceId,widget.documentID,int.parse(itemCount.text),widget.pricing,widget.title,widget.description,widget.imgSrc);
                         },
                        style: SleekButtonStyle.flat(
                          color: color,
                          inverted: false,
                          rounded: false,
                          size: SleekButtonSize.big,
                          context: context,
                        ),
                        child: Center(
                          child:Text("Add to cart", style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 15.0),),
                        ),
                      )
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 20.0, 5.0, 5.0),
                          child: new Text("\₱${oCcy.format(widget.pricing)}", style: TextStyle(fontSize: 24,color:color,),),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(30.0, 20.0, 5.0, 5.0),
                        child: new Text("\₱${oCcy.format(widget.priceCompare)}", style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 24,color: Colors.grey,),),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 5.0, 10.0),
                    child: new Text(widget.title, style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,fontSize: 23.0),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 8.0, 20.0),
                    child: new Text(widget.description, style: GoogleFonts.openSans( fontStyle: FontStyle.normal,fontSize: 18.0),),
                  ),
                ],
              ),
              childCount: 1,
            ),
          ),

        ],
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


