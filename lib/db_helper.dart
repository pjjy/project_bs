import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

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
        }
    );
  }

  Future addPhoneNumber(phoneNumber) async{
    fireStoreInstance.document("phone_number/$phoneNumber").setData(
        {
          "verified":"false",
          "phone_number":phoneNumber
        }
    );
  }

//  update number status to verified if otp code is correct
  Future verifyNumber(phoneNumber) async{
    fireStoreInstance.collection("phone_number").document(phoneNumber).updateData({"verified":"true"});
    print("updated");
  }

  Future deleteIfTimesUp(phoneNumber) async{
    fireStoreInstance.collection("phone_number").document(phoneNumber).delete();
  }

  Future checkPhoneNumber(checkPhoneNumber) async{
    final QuerySnapshot result = await Firestore.instance.collection('phone_number').where('verified',isEqualTo: "true").where('phone_number', isEqualTo:checkPhoneNumber).getDocuments();
//    final QuerySnapshot result = await FirebaseAuth.instance.
    final List < DocumentSnapshot > documents = result.documents;
    if(documents.length > 0){
      return true;
    }else{
      return false;
    }
  }
  

  Future addToCart(deviceId,documentID,itemCount,pricing,title,description,imgSrc) async {
    fireStoreInstance.document("user_cart/$deviceId").setData(
        {
        //date here
        }).then((value) {

          fireStoreInstance
              .collection("user_cart")
              .document(deviceId)
              .collection("cart_items")
              .document(documentID).setData({
                  "quantity":itemCount,
                  'imgPath':imgSrc,
                  'title':title,
                  'description':description,
                  'price':pricing
              },merge: true);
//              .add({
//                  "device_id" : deviceId,
//                  "product_id": productId,
//                  "quantity" : 450
//              });
    });
  }
}