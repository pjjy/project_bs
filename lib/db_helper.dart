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

  Future addToCart(deviceId,productId) async {
    fireStoreInstance.document("user_cart/$deviceId").setData(
        {
//          "device_id" : deviceId,
//          "product_id": productId,
//          "quantity" : 320
        }).then((value) {
//      print(value.documentID);
      fireStoreInstance
          .collection("user_cart")
          .document(deviceId)
          .collection("cart_items")
          .add({
              "device_id" : deviceId,
              "product_id": productId,
              "quantity" : 320
          });
    });
//    fireStoreInstance.collection("user_cart").add({
//      "device_id": deviceId
//    }).then((value) {
////      print(value.documentID);
//      fireStoreInstance
//          .collection("user_cart")
//          .document(value.documentID)
//          .collection("cart_items")
//          .add({""
//                "petName": "blacky",
//                "petType": "dog",
//                "petAge": 1
//              });
//    });
  }
}