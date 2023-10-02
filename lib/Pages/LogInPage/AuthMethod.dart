import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/LogInPage/userData.dart';

import '../../models/snack.dart';
import '../homepage.dart';
import 'SinInPage.dart';

class AuthMethod {
  SingUp(
      {required String Email,
      required String Name,
      required String Password,
      required List Ordar,
      required List TotalPrise,
      required double Lat,
      required double Lng,
      required int City,
      required String Dis,
      required BuildContext context,
      required String PhoneNumber,
      required String Token,
      }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password:Password,
      );
      showSnackBar(context: context, text: 'Account Created', color1: Colors.green);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogIn()));
      CollectionReference userdata =FirebaseFirestore.instance.collection('UserData');
      UserData UserDetals = UserData(
        EmailAddress: Email,
        Name:Name,
        Password: Password,
        Uid: credential.user!.uid,
        Ordar: Ordar,
        TotalPrise: TotalPrise,
        Lat:Lat ,
        Long: Lng,
        City: City,
        Dis:Dis,
        PhoneNumber: PhoneNumber,
        Token: Token,
      );
      userdata
          .doc(credential.user!.uid)
          .set(UserDetals.Convert2Map())

          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context: context, text: 'The password provided is too weak.', color1: Colors.redAccent);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context: context, text: 'The account already exists for that email.', color1: Colors.redAccent);
      }
    } catch (e) {
      showSnackBar(context: context, text:e.toString(), color1: Colors.redAccent);
    }
  }










  login({required BuildContext context}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text, password: password.text);
      nextpage = true;
      showSnackBar(
          context: context,
          text: 'LogInDone',
          color1: const Color.fromARGB(10, 10, 10, 0));
      if (nextpage == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        emailAddress.text='';
        password.text='';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(
            context: context,
            text: 'No user found for that email.',
            color1: Colors.red);
          loginloding=true;
      } else if (e.code == 'wrong-password') {
        showSnackBar(
            context: context,
            text: 'Wrong password provided for that user.',
            color1: Colors.red);
          loginloding=true;
      }
    }
  }







  Future<UserData> GetUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserData.convertSnap2Model(snap);
  }
}