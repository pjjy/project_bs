import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
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

  loadCart() {
    print("hello");
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
            "My cart",
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
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
              child: Text("Tap to edit Swipe to remove"),
            ),
            Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                      itemCount:5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 140.0,
                            width: 30.0,
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
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.rectangle,
                                              image: new DecorationImage(
                                                image: new NetworkImage('https://images-na.ssl-images-amazon.com/images/I/81isrpm8zDL._SL1500_.jpg'),
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      Container(
                                        child:Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(15, 1, 5, 1),
                                              child:Text('Bear Brand with alaska flavor', overflow: TextOverflow.clip,
                                                style: GoogleFonts.openSans(
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize: 15.0),
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(15, 1, 5, 5),
                                              child:Text('100 grams', overflow: TextOverflow.clip,
                                                style: GoogleFonts.openSans(
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                                                  child: new Text(
                                                    "₱ ${oCcy.format(40)} ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.green,
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
                      }),
                ),

            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: SleekButton(
                      onTap: () async {

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


