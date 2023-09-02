import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DataBaseRate{
  List Rating=[];
  GetDataRate({required String IdMarket}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(IdMarket).collection('Raiting').doc('0').get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      Rating=data['Rating'];
    } else {
      print("المستند غير موجود.");
    }
  }

  Rateing(
      {required int RateStars,
      required String Comment,
      required String Name,
      required DateTime Date,
      required String IdMarket,
      required String idRating,
      required int IdOrdar,
      }) async {
    await GetDataRate(IdMarket: IdMarket);
    Map Rateing={
        'RateStars':RateStars,
        'Comment':Comment,
        'Name':Name,
        'Uid':FirebaseAuth.instance.currentUser!.uid,
        'Date':Date,
        'IdMarket':IdMarket,
        'idRating':idRating,
        'IdOrdar':IdOrdar,
    };
    Rating.add(Rateing);
    await FirebaseFirestore.instance.collection('AdminData').doc(IdMarket).collection('Raiting').doc('0').set({'Rating':Rating});
    await FirebaseFirestore.instance.collection('Ordar').doc(IdOrdar.toString()).
    update({'OrdarRate':RateStars});
  }
}