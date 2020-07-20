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
        }
    );
  }

  Future addPhoneNumber(checkPhoneNumber) async{
    fireStoreInstance.collection("phone_number").add(
        {
          "phone_number":checkPhoneNumber
        }
    );
  }

  Future checkPhoneNumber(checkPhoneNumber) async{
    final QuerySnapshot result = await Firestore.instance.collection('phone_number').where('phone_number', isEqualTo:checkPhoneNumber).getDocuments();
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