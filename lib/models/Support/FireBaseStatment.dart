import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/snack.dart';
import 'package:intl/intl.dart';

class firebaseStatment{
  Future<void> StartNewSupportOrdar({required String massege,required int Which,required String Name}) async {
    CollectionReference AddDocumant =await FirebaseFirestore.instance.collection('SupportData');
    Map<String, dynamic> DataMassege = {'Massege':massege,'Which':Which};

    AddDocumant
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
          {'Massege': FieldValue.arrayUnion([DataMassege]),
           'Waiting':1,
            'Time':DateFormat.jm().format(DateTime.now()).toString(),
            'Uid':FirebaseAuth.instance.currentUser!.uid,
            'Name':Name,
          },)
        .then((value) => print("MassegeSent"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الرسالة');
  }

   SendMassege({required String massege,required int Which,required List Massage}) async {
    CollectionReference AddDocumant =await FirebaseFirestore.instance.collection('SupportData');
    Map<String, dynamic> DataMassege = {'Massege':massege,'Which':Which};
    Massage.add(DataMassege);
    AddDocumant
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {'Massege':Massage},)
        .then((value) => print("MassegeSent"))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم ارسال الرسالة');
  }


  Future<void> EndChat({required BuildContext context,required List massege,required String Name,required String Time,required int Rate}) async{
    if(massege.length==0){
      var users =await  FirebaseFirestore.instance.collection('SupportData').doc(FirebaseAuth.instance.currentUser!.uid);
      users.delete();
      showSnackBar(context: context, text: 'تم الغاء طلب الدعم', color1: Colors.red);
    }
   else{
      CollectionReference AddDocumant =await FirebaseFirestore.instance.collection('SupportDone');
      AddDocumant
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {'Massege':massege,
          'Waiting':'2',
          'Time':Time,
          'Uid':FirebaseAuth.instance.currentUser!.uid,
          'Name':Name,
          'Rate':Rate,
        },)
          .then((value) => print("MassegeSent"))
          .catchError((error) => print("Failed to add order: $error"));
      print('تم ارسال الرسالة');





      var users =await  FirebaseFirestore.instance.collection('SupportData').doc(FirebaseAuth.instance.currentUser!.uid);
      users.delete();
      showSnackBar(context: context, text: 'انتهى طلب الدعم', color1: Colors.red);
    }
  }

}