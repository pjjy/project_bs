import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'db_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {

  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {
  final db = ProjectBs();
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
          Badge(
            position: BadgePosition.topRight(top: 5, right: 5),
            badgeColor: Colors.green,
            badgeContent: Text('3'),
            child:  IconButton(
                icon: Icon(Ionicons.ios_cart,),
                onPressed: () {
                  db.addUser();
                }
            ),
          ),
          IconButton(
              icon: Icon(Ionicons.ios_search,),
              onPressed: () async{

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
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return ListTile(
                      title: Text(data['age'].toString()),

                  );
                },
          );
        },
      ),
    );
  }
}
