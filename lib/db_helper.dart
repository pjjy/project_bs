import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ProjectBs {
  final fireStoreInstance = Firestore.instance;

  Future addUser() async {
    fireStoreInstance.collection("user").add(
        {
          "name" : "zzzz",
          "age" : 30,
          "email" : "example@example.com",
          "address" : {
            "street" : "street 24",
            "city" : "new york"
          }
        });
  }

  Future addToCart(deviceId) async {
    fireStoreInstance.collection("user_cart").add(
        {
          "device_id" : deviceId,
          "product_id": 12,
          "quatity" : 30
        });
  }
}