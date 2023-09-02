import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Support/FireBaseStatment.dart';
import 'package:halaapp/models/Support/SuppurtPage.dart';
import 'package:lottie/lottie.dart';

class WaitingListSupport extends StatefulWidget {
  const WaitingListSupport({Key? key}) : super(key: key);

  @override
  State<WaitingListSupport> createState() => _WaitingListSupportState();
}
firebaseStatment DataBase =firebaseStatment();
class _WaitingListSupportState extends State<WaitingListSupport> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: h/30),
              height: h/10,
              width:w*0.98,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft:Radius.circular(15)),border: Border.all(width: 2,color: Colors.grey)),
              child:Center(child:
              Text('الدعم الفني',style: TextStyle(fontSize: w/18,
                  fontWeight: FontWeight.bold,color: Colors.grey),)),
            ),
            SizedBox(height: h/15,),
            Text('أنت على قائمة الإنتظار',style: TextStyle(fontSize: w/18,
                fontWeight: FontWeight.bold,color: Colors.grey),),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black12
              ),
              height: 300,
              width: 300,
              child: Lottie.asset('assets/lottie/waittttttttttt.json',fit: BoxFit.fill),),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('اشخاص',style: TextStyle(fontSize: 35,
                  fontWeight: FontWeight.bold,color: Colors.grey),),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('SupportData').where('Waiting', isEqualTo: 1).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    if (snapshot.data!.size == 0) {
                      Timer(Duration(seconds: 1), () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SupportPage()),);
                      });
                      return Text(
                        '${snapshot.data!.size}',
                        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.red),
                      );
                    }
                    return Text(
                      '${snapshot.data!.size}',
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.red),
                    );
                  },
                ),

                Text('يوجد أمامك',style: TextStyle(fontSize: 35,
                  fontWeight: FontWeight.bold,color: Colors.grey),),
            ],),
            SizedBox(height: 30,),
            InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      content: Container(
                        height: 150,color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('هل انت متأكد من مغادرة طلبات الدعم ؟',style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black54
                            ),),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(onPressed: () async {
                                  await DataBase.EndChat(context: context, massege: [], Name: '', Time: '',Rate: 0);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("نعم",style: TextStyle(
                                    color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                                ),),
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                ),
                                ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text("لا",style: TextStyle(
                                    color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                                ),),
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ,);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                width: w/2,
                height: h/17,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(56, 95, 172, 1),
                          Color.fromRGBO(1, 183, 168, 1)
                        ]
                    )
                ),
                child: Center(child: Text('مغادرة',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
