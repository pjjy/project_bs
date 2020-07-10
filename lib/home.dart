import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'item_details.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = ProjectBs();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final fireStoreInstance = Firestore.instance;
  bool isLoading = false;
  bool isAppBarExpanded = false;
  List list = new List();


  @override
  void initState() {
    super.initState();
  }

  loadStore(){
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: new IconThemeData(color: Colors.black),
        actions: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("user_cart").snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData ?
              Center(
                child: Badge(
                  position: BadgePosition.topRight(top: 5, right: 5),
                  badgeColor: Colors.green,
                  badgeContent: Text('0',style: TextStyle(color: Colors.white,),),
                  child:  IconButton(
                      icon: Icon(Ionicons.ios_cart,),
                      onPressed: () {
                        db.addUser();
                      }
                  ),
                ),
              ):
              Badge(
                position: BadgePosition.topRight(top: 5, right: 5),
                badgeColor: Colors.green,
                badgeContent: Text('${snapshot.data.documents.length}',style: TextStyle(color: Colors.white,),),
                child:  IconButton(
                    icon: Icon(Ionicons.ios_cart,),
                    onPressed: () {
                      db.addUser();
                    }
                ),
              );
            },
          ),

          IconButton(
              icon: Icon(Ionicons.ios_search,),
              onPressed: () {
              }
          ),
        ],
        title: Text(
          "Alturush",
          style: GoogleFonts.fasterOne(
              color: Colors.green,
              fontStyle: FontStyle.normal,
              fontSize: 18.0),
        ),
      ),
      drawer:Container(
        color: Colors.red,
        width: 280,
        child: Drawer(
          child: Container(
            color: Colors.white,
            child:ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  child:Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Text("Sign up/Log in",style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 23.0),),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),

                      ListTile(
                          leading: Icon(Icons.person,size: 30.0,color: Colors.green,),
                          title: Text('Profile',style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 16.0),),
                          onTap: () async{

                          }
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline,size: 30.0,color: Colors.green,),
                        title: Text('About',style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 16.0),),
                      ),
                      ListTile(
                          leading: Icon(Icons.help_outline,size: 30.0,color: Colors.green,),
                          title: Text('Log out',style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 16.0),),
                          onTap: () async{

                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView(
//              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
//                      SizedBox(
//                        height: 10.0,
//                      ),
                SizedBox(
                  height: 210.0,
//                        width: 200.0,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    dotIncreasedColor: Colors.white,
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    dotVerticalPadding: 10.0,
                    showIndicator: true,
                    indicatorBgPadding: 7.0,
                    images: [
                      Container(
                        height: 190.0,
                        width:
                        MediaQuery.of(context).size.width - 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new NetworkImage(
                                  'https://www.tasteofhome.com/wp-content/uploads/2018/01/Crispy-Fried-Chicken_EXPS_FRBZ19_6445_C01_31_3b-2.jpg'),
                              fit: BoxFit.fitWidth),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 140.0, 5.0, 0.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Chicken lurat",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24.0),
                                ),
                                Text(
                                  "₱500.00",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 190.0,
                        width:
                        MediaQuery.of(context).size.width - 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                          image: DecorationImage(
                              image: new NetworkImage(
                                'https://i.pinimg.com/originals/f0/0f/ac/f00fac312c7e1a733c47c1644c3be8d3.png',
                              ),
                              fit: BoxFit.fitWidth),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 140.0, 5.0, 0.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Chicken Tsae",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24.0),
                                ),
                                Text(
                                  "₱ 500.00",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 24.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 5, 5),
                  child: new Text(
                    "Explore Packages",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),

                Container(
                  height: 210,
                  width: 130,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                      Expanded(
                                        child:  Image.network(
                                          'https://placeimg.com/640/480/any',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.0,
                                      ),
                                      Padding(
                                        padding:EdgeInsets.all(5.0),
                                        child:Text("address"),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.all(5.0),
                                        child: Text("₱ ${oCcy.format(400)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green,),
                                      )
                                      ),
                                      SizedBox(
                                        height: 1.0,
                                      ),
                                ],
                              ),
                          ),
                          elevation: 0.0,
                        );
                      }),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 5, 5),
                  child: new Text(
                    "Best seller",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("products").snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData ?
                        Center(child: CircularProgressIndicator()):
                        GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.1),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return Card(
                            elevation: 0.0,
                            margin: EdgeInsets.all(2),
                            child:InkWell(
                              onTap: (){
                                print(data.documentID);
                                Navigator.of(context).push(_itemDetails(data.documentID,data['imgSrc'],data['title'],data['pricing']['price'],data['pricing']['price_compare'],data['description']));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    child: Image.network(data['imgSrc'],
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20/4,vertical: 20.0 / 4),
                                    child: Text(data['title'].toString(),
                                      style: TextStyle(fontSize: 14,),

                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child:Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20/4,vertical: 20.0 / 4),
                                          child: Text(
                                            "\₱${oCcy.format(data['pricing']['price'])}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20/4,vertical: 20.0 / 4),
                                          child: Text("\₱${oCcy.format(data['pricing']['price_compare'])}",
                                            style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          );

                        });
                  },
                ),
                ],
              ),
            ),
          ],
        ),
      );
    }
}

Route _itemDetails(documentID,imgSrc,title,pricing,priceCompare,description) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ItemDetail(documentID:documentID,imgSrc:imgSrc,title:title,pricing:pricing,priceCompare:priceCompare,description:description),
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
