import 'package:shared_preferences/shared_preferences.dart';

class Functions {
  Future saveCheckOut(deliveryAddress,phoneNumber,specialInstruction) async{

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('deliveryAddress',deliveryAddress);
          prefs.setString('phoneNumber', phoneNumber);
          prefs.setString('specialInstruction', specialInstruction);

  }
}