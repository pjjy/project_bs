import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_account.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'review_order.dart';
import 'functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOut extends StatefulWidget {

  @override
  _CheckOut createState() => _CheckOut();
}

class _CheckOut extends State<CheckOut> {
  final functions = Functions();
  final _deliveryAddressText = TextEditingController();
  final _phoneNumberText = TextEditingController();
  final _specialInstructionText = TextEditingController();
  var _formKeyDeliveryAddressText = GlobalKey<FormState>();
  var _formKeyPhoneNumberText = GlobalKey<FormState>();
  var _formKeySpecialInstructionText = GlobalKey<FormState>();
  Color color = const Color(0xff0084ff);
  String deliveryAddress = "i.e Old Capitol Complex, Carlos P. Garcia Avenue corner JS Torralba Street, Poblacion, Tagbilaran City, Bohol";
  String phoneNumberTemp="";
  String phoneNumber="";
  String specialInstruction = "";
  
  
  void detectLastDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('phoneNumber') != null){
      setState(() {
        phoneNumber = prefs.getString('phoneNumber');
      });

    }else{
      setState(() {
        phoneNumber = "+639107961118";
      });
    }
    //
    if(prefs.getString('specialInstruction') != null){
      setState(() {
        specialInstruction =  prefs.getString('specialInstruction');
      });
    }else{
      setState(() {
        specialInstruction = "i.e Don't get items with dents thank but if no choice the get it";
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    detectLastDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _deliveryAddressText.dispose();
    _phoneNumberText.dispose();
    _specialInstructionText.dispose();
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
                onPressed: () async {
                  print("hello");
                }
            ),
          ],
          title: Text(
            "Check out",
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontStyle: FontStyle.normal,
                fontSize: 22.0),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 4.0,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return  AlertDialog (
                                title:Row(
                                  children: <Widget>[
                                    Text('Delivery address',style:TextStyle(fontSize: 15.0),),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width-100.0,
                                    child: Padding(
                                      padding:EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      child:Center(
                                         child: Form(
                                           key: _formKeyDeliveryAddressText,
                                           child:TextFormField(
                                             controller: _deliveryAddressText,
                                             validator: (value) {
                                               if (value.isEmpty) {
                                                 return 'Please enter delivery address';
                                               }
                                               return null;
                                             },
                                             decoration: InputDecoration(
                                               contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                                             ),
                                             autofocus: true,
                                             minLines: 1,
                                             maxLines: 5,
                                             style: TextStyle(
                                                 fontSize: 15
                                             ),
                                           ),
                                         ),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Done',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      setState(() {
                                        if(_formKeyDeliveryAddressText.currentState.validate()){
                                          deliveryAddress = _deliveryAddressText.text;
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.0,
                          width: MediaQuery.of(context).size.width / 10.0,
                          child:Card(
                            elevation: 0.0,
                            shape: Border(
                                right: BorderSide(color: Colors.black12, width: 1),
                                left: BorderSide(color: Colors.black12, width: 1),
                                top: BorderSide(color: Colors.black12, width: 1),
                                bottom: BorderSide(color: Colors.black12, width: 1)
                            ),
                            color: Colors.white,
                            borderOnForeground: true,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15.0, 2.0,  0.0, 1.0),
                                            child:  Container(
                                              height: 25.0,
                                              width: 25.0,
                                              child:SvgPicture.asset('assets/svg/house.svg'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                            child:Text('Delivery Address',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context).size.width / 28.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child:  Padding(
                                          padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                          child:Text(deliveryAddress, overflow: TextOverflow.fade,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black54,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context).size.width / 30.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0,  15.0, 1.0),
                                      child: Icon(Icons.arrow_forward_ios, color: Colors.black26,size: 18.0,),
                                    ),
                                  ],
                                ),


                              ],
                            ),

                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.0,
                          width: MediaQuery.of(context).size.width / 10.0,
                          child:Card(
                            elevation: 0.0,
                            shape: Border(
                                right: BorderSide(color: Colors.black12, width: 1),
                                left: BorderSide(color: Colors.black12, width: 1),
                                top: BorderSide(color: Colors.black12, width: 1),
                                bottom: BorderSide(color: Colors.black12, width: 1)
                            ),
                            color: Colors.white,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15.0, 2.0,  0.0, 1.0),
                                            child:  Container(
                                              height: 25.0,
                                              width: 25.0,
                                              child:SvgPicture.asset('assets/svg/pay.svg'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                            child:Text('Payment method',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context).size.width / 28.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                              child:Text('Cash on delivery ', overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 30.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0,  15.0, 1.0),
                                      child: Icon(Icons.arrow_forward_ios, color: Colors.black26,size: 18.0,),
                                    ),
                                  ],
                                ),


                              ],
                            ),

                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return  AlertDialog (
                                title:Row(
                                  children: <Widget>[
                                    Text('Phone number',style:TextStyle(fontSize: 15.0),),
                                  ],
                                ),
                                content: SingleChildScrollView(

                                  child: Container(
                                    width: MediaQuery.of(context).size.width-100.0,
                                    child: Padding(
                                      padding:EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      child:Center(
                                        child:Form(
                                          key: _formKeyPhoneNumberText,
                                          child:TextFormField(
                                            maxLength: 10,
                                            controller: _phoneNumberText,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter your active phone number';
                                              }
                                              if (value.length < 10) {
                                                return 'Please enter your active phone number';
                                              }
                                              if (value.substring(0,1) != '9') {
                                                return 'Please enter a valid phone number';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              prefixText: "+63",prefixStyle:TextStyle(color: Colors.black,fontStyle: FontStyle.normal, fontSize: 15.0),
                                            ),
                                            autofocus: true,
                                            minLines: 1,
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: 15
                                            ),
                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Done',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      setState(() {
                                        if(_formKeyPhoneNumberText.currentState.validate()){
                                          phoneNumberTemp = _phoneNumberText.text;
                                          phoneNumber = '+63$phoneNumberTemp';
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.0,
                          width: MediaQuery.of(context).size.width / 10.0,
                          child:Card(
                            elevation: 0.0,
                            shape: Border(
                                right: BorderSide(color: Colors.black12, width: 1),
                                left: BorderSide(color: Colors.black12, width: 1),
                                top: BorderSide(color: Colors.black12, width: 1),
                                bottom: BorderSide(color: Colors.black12, width: 1)
                            ),
                            color: Colors.white,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15.0, 2.0,  0.0, 1.0),
                                            child:  Container(
                                              height: 25.0,
                                              width: 25.0,
                                              child:SvgPicture.asset('assets/svg/contact.svg'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                            child:Text('Phone number',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context).size.width / 28.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                              child:Text(phoneNumber, overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 30.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0,  15.0, 1.0),
                                      child: Icon(Icons.arrow_forward_ios, color: Colors.black26,size: 18.0,),
                                    ),
                                  ],
                                ),


                              ],
                            ),

                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return  AlertDialog (
                                title:Row(
                                  children: <Widget>[
                                    Text('Special instructions',style:TextStyle(fontSize: 15.0),),
                                  ],
                                ),
                                content: SingleChildScrollView(

                                  child: Container(
                                    width: MediaQuery.of(context).size.width-100.0,
                                    child: Padding(
                                      padding:EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      child:Center(
                                        child:Form(
                                          key:_formKeySpecialInstructionText,
                                          child:TextFormField(
                                            controller: _specialInstructionText,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter special instructions';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'i.e. please don\'t get item with dents',
                                              contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                                            ),
                                            autofocus: true,
                                            minLines: 1,
                                            maxLines: 5,
                                            style: TextStyle(
                                                fontSize: 15
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Clear',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.remove("specialInstruction");
                                      specialInstruction = "";
                                      _specialInstructionText.clear();                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Cancel',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Done',style: TextStyle(fontSize: 16.0,color:color,)),
                                    onPressed: () async{
//                                      setState(() {
//                                        specialInstruction = _specialInstructionText.text;
//                                      });
//                                        Navigator.of(context).pop();
                                      setState(() {
                                        if(_formKeySpecialInstructionText.currentState.validate()){
                                          specialInstruction = _specialInstructionText.text;
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.0,
                          width: MediaQuery.of(context).size.width / 10.0,
                          child:Card(
                            elevation: 0.0,
                            shape: Border(
                                right: BorderSide(color: Colors.black12, width: 1),
                                left: BorderSide(color: Colors.black12, width: 1),
                                top: BorderSide(color: Colors.black12, width: 1),
                                bottom: BorderSide(color: Colors.black12, width: 1)
                            ),
                            color: Colors.white,
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(15.0, 2.0,  0.0, 1.0),
                                            child:  Container(
                                              height: 25.0,
                                              width: 25.0,
                                              child:SvgPicture.asset('assets/svg/strategy.svg'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                            child:Text('Special instruction',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context).size.width / 28.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0.0, 1.0,  0.0, 1.0),
                                            child:Text('(Optional)',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black45,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: MediaQuery.of(context).size.width / 30.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(45.0, 1.0,  5.0, 10.0),
                                              child:Text(specialInstruction, overflow: TextOverflow.fade,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.black54,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: MediaQuery.of(context).size.width / 30.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0.0, 0.0,  15.0, 1.0),
                                      child: Icon(Icons.arrow_forward_ios, color: Colors.black26,size: 18.0,),
                                    ),
                                  ],
                                ),


                              ],
                            ),

                          ),
                        ),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height / 4.0,
                        width: MediaQuery.of(context).size.width / 10.0,
                        child:Card(
                          elevation: 0.0,
                          color: Colors.white,
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10.0, 1.0,  0.0, 1.0),
                                          child:Text('Charges',
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: MediaQuery.of(context).size.width / 28.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                                child:Text('Sub total',
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                              Spacer(), //
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                                child:Text('2000.00', overflow: TextOverflow.fade,
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                                child:Text('Discount',
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                              Spacer(), //
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                                child:Text('10%', overflow: TextOverflow.fade,
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(20.0, 0.0,  0.0, 10.0),
                                                child:Text('Delivery fee',
                                                  style: GoogleFonts.openSans(

                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                              Spacer(), //
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 10.0),
                                                child:Text('Free', overflow: TextOverflow.fade,
                                                  style: GoogleFonts.openSans(
                                                      fontWeight: FontWeight.bold,
                                                      color: color,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0.0, 0.0,  20.0, 10.0),
                                                child:Text('30.00', overflow: TextOverflow.fade,
                                                  style: GoogleFonts.openSans(
                                                      decoration: TextDecoration.lineThrough,
                                                      color: Colors.black54,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: MediaQuery.of(context).size.width / 27.0),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),

                        ),
                      ),
                    ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SleekButton(
                      onTap: () async {

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
                          "Total: \₱2,220.00",
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
                        functions.saveCheckOut(deliveryAddress,phoneNumber,specialInstruction);
                        Navigator.of(context).push(_reviewOrder());
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
                          "Check Out",
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
          ],
        ),
//      ),
      ),
    );
  }
}

Route _reviewOrder() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ReviewOrder(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
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

