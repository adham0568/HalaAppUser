import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/snack.dart';

class FireBaseServces{
  Future<void> DataUser({required String Name,required String Email,required String Phone,required BuildContext context}) async {

    CollectionReference listItem =FirebaseFirestore.instance.collection('UserData');

    Map<String, dynamic> UserData = {
      'Name': Name,
      'EmailAddress':Email,
      'PhoneNumber':Phone,
    };

    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(UserData)
        .then((value) => showSnackBar(context: context, text: 'تم تحديث البيانات', color1: Colors.green))
        .catchError((error) => showSnackBar(context: context, text: "Failed to add order: $error", color1: Colors.green) );

    print('تم تعديل حالة الطلب بنجاح في Firestore');
  }

  Future<void> EditLocation({required int City,required String Dis,required double Lat,required double Long,required BuildContext context}) async {

    CollectionReference listItem =FirebaseFirestore.instance.collection('UserData');

    Map<String, dynamic> UserData = {
      'Dis': Dis,
      'City':City,
      'Lat':Lat,
      'Long':Long,
    };

    listItem
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(UserData)
        .then((value) => showSnackBar(context: context, text: 'تم تحديث الموقع', color1: Colors.green))
        .catchError((error) => showSnackBar(context: context, text: "Failed to add order: $error", color1: Colors.green) );

    print('تم تعديل حالة الطلب بنجاح في Firestore');
  }
}