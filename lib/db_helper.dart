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
  }

  Future deleteIfTimesUp(phoneNumber) async{
    fireStoreInstance.collection("phone_number").document(phoneNumber).delete();
  }

  Future checkOut() async{
   QuerySnapshot snapshot = await fireStoreInstance.collection("user_cart/64a6d6eb0e8cf55c/cart_items").getDocuments();
   fireStoreInstance.collection("customer_order").add(
       {
         "customer" :  {
           "contact" : "+63093213216",
           "location" : "9.6602978 123.8496343"
         },
         "name:":{
           "contact" : "Paul Jearic Niones",
           "location" : "new york"
         },
         "datetime":{
           "created":"created",
           "delivered":"delivered",
           "inTransit":"inTransit",
           "packaging":"packaging",
           "updated":"updated"
         },
         "order_details":{
           "deliveryCharge":"400",
           "tip":"40",
           "totalPrice":"440",
         },
         "recipient":{
           "contact":"+6309465465",
           "location":{
             "barrio":"del carmen este",
             "landmark":"dool sa akasya",
             "municipality":"balilihan",
             "street":"juan street",
           },
           "name":"Paul Jearic",
           "last":"Niones"
         },
         "riders":{
           "contact":"+63985621568",
           "name":{
             "first":"Renan",
             "last":"Ocoy"
           },
           "rideRef":"",
         },

         "status":{
           "delivery":"True",
           "inTransit":"True",
           "packaging":"True"
         }
       }).then((value){

       for(var mes in snapshot.documents){
         fireStoreInstance.collection("customer_order").document(value.documentID).collection("basket").document(mes.documentID).setData({
           "quantity":mes.data['quantity'],
           "title":mes.data['title'],
         });

       }


   });

  }

  Future checkPhoneNumber(checkPhoneNumber) async{
    final QuerySnapshot result = await Firestore.instance.collection('phone_number').where('verified',isEqualTo: "true").where('phone_number', isEqualTo:checkPhoneNumber).getDocuments();
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
          fireStoreInstance.collection("user_cart").document(deviceId).collection("cart_items").document(documentID).setData({
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