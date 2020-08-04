import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'item_details.dart';
import 'package:device_info/device_info.dart';
import 'user_cart.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

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
  var deviceId;
  int gridCount;
  Color color = const Color(0xff0084ff);

  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: Text('Home'), icon: Ionicons.md_home),
    TitledNavigationBarItem(title: Text('Categories'), icon: Ionicons.md_grid),
    TitledNavigationBarItem(title: Text('Wish'), icon: Ionicons.md_heart),
    TitledNavigationBarItem(title: Text('Profile'), icon: Ionicons.md_person),
  ];

  bool navBarMode = false;

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
  Widget build(BuildContext context) {
    _get1();
    MediaQuery.of(context).size.width >= 600 ? gridCount = 3 : gridCount = 2;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        actions: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("user_cart").document(deviceId).collection('cart_items').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData ?
              Center(
                child: Badge(
                  position: BadgePosition.topRight(top: 5, right: 5),
                  badgeColor: color,
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
                position: BadgePosition.topRight(top: 5, right: 5),
                badgeColor: color,
                badgeContent: Text('${snapshot.data.documents.length}',style: TextStyle(color: Colors.white,),),
                child:  IconButton(
                    icon: Icon(Ionicons.ios_cart,),
                    onPressed: () {
                      Navigator.of(context).push(_viewCart());
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
              color: color,
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
                          leading: Icon(Icons.person,size: 30.0,color:color,),
                          title: Text('Profile',style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 16.0),),
                          onTap: () async{
                          }
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline,size: 30.0,color: color,),
                        title: Text('About',style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontWeight:FontWeight.bold,fontSize: 16.0),),
                      ),
                      ListTile(
                          leading: Icon(Icons.help_outline,size: 30.0,color: color,),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView(
//              shrinkWrap: true,
//              physics: BouncingScrollPhysics(),
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
                          padding: EdgeInsets.fromLTRB(35.0, 120.0, 5.0, 0.0),
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
                                      color: Colors.black87,
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
                                'https://www.treehugger.com/thmb/oVLB_Em5OBGo8Qc5M9i8g4lg2bM=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__treehugger__images__2020__04__grocery-cart-a12224a52f8f4e42a3a5464cfe0caa28.jpg',
                              ),
                              fit: BoxFit.fitWidth),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(35.0, 120.0, 5.0, 0.0),
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
                                      color: Colors.black87 ,
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
                Divider(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
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
                                          fit: BoxFit.scaleDown,
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
                                        child: Text("₱ ${oCcy.format(400)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: color,),
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
                Divider(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: new Text(
                    "Best seller",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),
                FutureBuilder(
                  future: Firestore.instance.collection("products").getDocuments(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData ?
                        Center(child: CircularProgressIndicator()):
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridCount,
                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.1),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = snapshot.data.documents[index];
                          return InkWell(
                                  onTap: () async{
                                    var deviceId = await _getId();
                                    Navigator.of(context).push(_itemDetails(deviceId,data.documentID,data['images'][0]['imgSrc'],data['info']['title'],data['pricing']['price'],data['pricing']['price_compare'],data['info']['description']));
                                   },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                              top: BorderSide(width: 1.0, color: color)),
                                        color: Colors.white,
                                      ),
                                      margin: EdgeInsets.all(1),
                                      child: Column(
                                        children: <Widget>[
                                          new Expanded(
                                            child: Image.network(
                                              data['images'][0]['imgSrc'],
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            title: Text(
                                              "${data['info']['title']}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black87),
                                            ),
                                            subtitle: Text(
                                              "\₱${oCcy.format(data['pricing']['price'])}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: color,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
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
        bottomNavigationBar: TitledBottomNavigationBar(
          enableShadow: false,
          onTap: (index) => print("Selected Index: $index"),
//          reverse: ,
          curve: Curves.easeInBack,
          items: items,
          activeColor: color,
          inactiveColor: Colors.blueGrey,
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