import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:sleek_button/sleek_button.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _fullName = TextEditingController();
  final _password = TextEditingController();
  final _address = TextEditingController();
  final _emailLogIn = TextEditingController();
  final _passwordLogIn = TextEditingController();
  final countryCode = "+63";
  Color color = const Color(0xff0084ff);
  var _formKey = GlobalKey<FormState>();
  var _formKey1 = GlobalKey<FormState>();
  var validate;
  var signUpMessage;
  var signUpErrorText;
  var signInErrorText;
  var signInErrorTextPass;
  var signInMessage;
  var errorTextPass;
  bool _isSigUpLoading = false;
  bool _isSigInLoading = false;
  bool boolErrorSignUpTextEmail = false;
  bool boolErrorSignUpTextPass = false;

  bool boolSignInErrorTextEmail = false;
  bool boolSignInErrorTextPass = false;
  TabController _tabController;

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


  void addPhoneNumber(_email,_password,_fullName,_phoneNumber,_address) async{
    var exist = await db.checkPhoneNumber(_phoneNumber);

    if(exist == true){
      validate = true;
    }
    if(exist == false){
      validate = false;
      signUpMessage = await db.signUpWithEmailPassword(_email,_password,_fullName,_phoneNumber,_address);
      if(signUpMessage == true){
        if (!mounted) return;
        setState(() {
          _isSigUpLoading = false;
          print("pwede naka musod");
        });
      }
      if(signUpMessage=='ERROR_WEAK_PASSWORD'){
        if (!mounted) return;
        setState(() {
          _isSigUpLoading = false;
          boolErrorSignUpTextPass = true;
          errorTextPass = "Password should be at least 6 characters";
        });
      }
      else{
        if (!mounted) return;
        setState(() {
          _isSigUpLoading = false;
          boolErrorSignUpTextPass = false;
          boolErrorSignUpTextEmail = false;
        });
      }
      if(signUpMessage=='ERROR_INVALID_EMAIL'){
        if (!mounted) return;
        setState(() {
          _isSigUpLoading = false;
          boolErrorSignUpTextEmail = true;
          signUpErrorText = "The email address is badly formatted.";
        });
      }
      if(signUpMessage=='ERROR_EMAIL_ALREADY_IN_USE'){
        if (!mounted) return;
        setState(() {
          _isSigUpLoading = false;
          boolErrorSignUpTextEmail = true;
          signUpErrorText = "The email address is already in use by another account.";
        });
      }
//      else{
//        setState(() {
////          boolErrorTextPass = false;
//          boolErrorTextEmail = false;
//        });
//      }
    }
  }

  test() {
    signUpErrorText = null;
    errorTextPass = null;
    _isSigUpLoading = true;
    addPhoneNumber(_email.text,_password.text,_fullName.text,countryCode + _phoneNumber.text,_address.text);
  }

  void signIn() async{
    signInErrorText = null;
    signInErrorTextPass = null;
    _isSigInLoading = true;

    signInMessage = await db.signIpWithEmailPassword(_emailLogIn.text,_passwordLogIn.text);
    print(signInMessage);
    if(signInMessage == true){
      if (!mounted) return;
      setState(() {
        _isSigInLoading = false;
        boolSignInErrorTextEmail = true;
        print('pwede naka mo sud from sign in');
      });
    }
    if(signInMessage=='ERROR_INVALID_EMAIL'){
      if (!mounted) return;
      setState(() {
        _isSigInLoading = false;
        boolSignInErrorTextEmail = true;
        signInErrorText = "The email address is badly formatted.";
      });

    }
    if(signInMessage=='ERROR_USER_NOT_FOUND'){
      if (!mounted) return;
      setState(() {
        _isSigInLoading = false;
        boolSignInErrorTextEmail = true;
        signInErrorText = "This email does not exist.";
      });
    }
    if(signInMessage=='ERROR_WRONG_PASSWORD'){
      if (!mounted) return;
      setState(() {
        _isSigInLoading = false;
        boolSignInErrorTextPass = true;
        signInErrorTextPass = "Your password is invalid for this account";
      });
     if(signInMessage == 'ERROR_NETWORK_REQUEST_FAILED'){
       if (!mounted) return;
       setState(() {
         _isSigInLoading = false;
         boolSignInErrorTextPass = true;
         signInErrorTextPass = "Request failed try again";
         signInErrorText = "Request failed try again";
       });
     }
    }
    if(signInMessage=='ERROR_TOO_MANY_REQUESTS'){
      if (!mounted) return;
      setState(() {
        _isSigInLoading = false;
        boolSignInErrorTextEmail = true;
        signInErrorText = "Too many request, try again later";
      });
    }
    // ERROR_INVALID_EMAIL
    // ERROR_USER_NOT_FOUND
    // ERROR_WRONG_PASSWORD
    // ERROR_TOO_MANY_REQUESTS
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
      child:DefaultTabController(
        length: 2,
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
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: color,
              tabs: [
                Tab(
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Log in",
                    style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ],
            ),
            title: Text(
              "Account",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child:Expanded(
                          child:Scrollbar(
                            child: ListView(
                              padding: EdgeInsets.zero,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                                    child: new Text(
                                      "Email",
                                      style: GoogleFonts.openSans(color: Colors.black54, fontStyle: FontStyle.normal, fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    child: new TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor:Colors.blueGrey,
                                      controller: _email,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'juan@yourmail.com',
                                        errorText: boolErrorSignUpTextEmail == true ? signUpErrorText: null,
                                        hintStyle:  GoogleFonts.openSans(color: Colors.grey,fontStyle: FontStyle.normal, fontSize: 15.0),
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
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
                                      style: GoogleFonts.openSans(color: Colors.black54,fontStyle: FontStyle.normal, fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    child: new TextFormField(
                                      obscureText: true,
                                      textInputAction: TextInputAction.done,
                                      cursorColor:Colors.blueGrey,
                                      controller: _password,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter password';
                                        }
//                                        if(value.length <6){
//                                          return 'Password should be at least 6 characters';
//                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                                        errorText: boolErrorSignUpTextPass == true ? errorTextPass: null,
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
                                      "Full Name",
                                      style: GoogleFonts.openSans(color: Colors.black54,fontStyle: FontStyle.normal, fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    child: new TextFormField(
                                      textInputAction: TextInputAction.done,
                                      cursorColor:Colors.blueGrey,
                                      controller: _fullName,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter full name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Juan Dela Cruz',

                                        hintStyle:  GoogleFonts.openSans(color: Colors.grey,fontStyle: FontStyle.normal, fontSize: 15.0),
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
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
                                      style: GoogleFonts.openSans(color: Colors.black54,fontStyle: FontStyle.normal, fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: new TextFormField(
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
                                            inputFormatters:[BlacklistingTextInputFormatter(new RegExp('[.-]'))],
                                            cursorColor:Colors.blueGrey,
                                            controller: _phoneNumber,
                                            validator: (value){
                                              if (value.isEmpty) {
                                                return 'Please enter number';
                                              }if(value.length < 10 || _phoneNumber.text[0] != '9' ){
                                                return 'Please enter a valid phone number';
                                              }
                                              return null;
                                            },

                                            decoration: InputDecoration(
                                              errorText: validate == true ? 'This number is already taken' : null,
                                              prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+63',style:   TextStyle(color: Colors.grey,fontStyle: FontStyle.normal, fontSize: 15.0),)),
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                                    child: new Text(
                                      "Address",style: GoogleFonts.openSans(color: Colors.black54,fontStyle: FontStyle.normal, fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
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
                            horizontal: 20.0, vertical: 1.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: _isSigUpLoading == false ? (){
                                      print("hello");
                            }:null,
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
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child:_isSigUpLoading ? Center(child:SpinKitRing(
                            color: Colors.blue,
                            lineWidth: 5.0,
                            size: 40,
                          ),) : SleekButton(
                            onTap: (){
                              if(_formKey.currentState.validate()){
                                test();
                              }
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
                                    fontSize: 17.0),
                              ),
                            ),
                          )
                      ),
                    ],
                ),

              //login tab
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey1,
                    child:Expanded(
                      child:Scrollbar(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                child: SleekButton(
                                  onTap: (){
                                  },
                                  style: SleekButtonStyle.flat(
                                    color: color,
                                    inverted: false,
                                    rounded: false,
                                    size: SleekButtonSize.big,
                                    context: context,
                                  ),
                                  child:Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Ionicons.logo_facebook),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "Log in with facebook",
                                          style: GoogleFonts.openSans(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0),
                                        ),
                                  ],
                                ),
                                )
                            ),
                            SizedBox(
                              height: 13.0,
                            ),
                            Center(
                              child: Text("Or",style: GoogleFonts.openSans(fontStyle: FontStyle.normal,fontSize: 15.0)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(35.0, 10.0, 5.0, 5.0),
                              child: new Text(
                                "Email",
                                style: GoogleFonts.openSans(
                                    fontStyle: FontStyle.normal, fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                              child: new TextFormField(
                                textInputAction: TextInputAction.done,
                                cursorColor:Colors.blueGrey,
                                controller: _emailLogIn,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'juan@yourmail.com',
                                  errorText: boolSignInErrorTextEmail ? signInErrorText : null,
                                  hintStyle:  GoogleFonts.openSans(color: Colors.grey,fontStyle: FontStyle.normal, fontSize: 15.0),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(35, 20, 5, 5),
                              child: new Text("Password", style: GoogleFonts.openSans(fontStyle: FontStyle.normal, fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              child: new TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                cursorColor:Colors.blueGrey,
                                controller: _passwordLogIn,
                                validator: (value) {
                                  if (value.isEmpty){
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorText: boolSignInErrorTextPass?signInErrorTextPass:null,
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 25.0),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: _isSigInLoading ? Center(child:SpinKitRing(
                        color: Colors.blue,
                        lineWidth: 5.0,
                        size: 40,
                      ),) : SleekButton(
                        onTap: (){
                            if(_formKey1.currentState.validate()){
                              signIn();
                            }
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
                            "Log in",
                            style: GoogleFonts.openSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
