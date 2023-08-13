import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/Shortcuts/PreviousOrdarDetales.dart';
import 'package:halaapp/Pages/appPages/Sections/ChackeOut/DoneOrdar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../provider/DataUser.dart';


class PreviousOrdar extends StatefulWidget {
  const PreviousOrdar({Key? key}) : super(key: key);

  @override
  State<PreviousOrdar> createState() => _PreviousOrdarState();
}
String OrdarStat='';
class _PreviousOrdarState extends State<PreviousOrdar> {
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/Img/logowelcome.png',
          height: 100,
          color: Colors.white,
        ),
        actions: const [
          SizedBox(
            height: 50,
            width: 50,
          )
        ],
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ])),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('Ordar').where('User',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                return SizedBox(
                  height: 700,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(data[index]['OrdarStates']==0){
                        OrdarStat='بانتظار قبول طلبك';}
                      else if(data[index]['OrdarStates']==1){
                        OrdarStat='جاري تحضير طلبك';
                      }
                      else if(data[index]['OrdarStates']==2){
                        OrdarStat='"يتم تجهيز الطلب';
                      }
                      else if(data[index]['OrdarStates']==3){
                        OrdarStat='الطلب في طريقه اليك';
                      }
                      else if(data[index]['OrdarStates']==4){
                        OrdarStat='صحتين 😍';
                      }
                      else { OrdarStat='فشل الطلب 🥲';}
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousOrdarDetales(
                            data:data[index],
                          ),));
                        },
                        child:StreamBuilder<QuerySnapshot>(
                          stream:  FirebaseFirestore.instance.collection('AdminData').where('Uid',isEqualTo: data[index]['UidMarket']).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.size,itemBuilder: (context, index1) =>
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromRGBO(56, 95, 172, 1),
                                          Color.fromRGBO(1, 183, 168, 1)
                                        ]),),
                                  height: h/4,
                                  margin: const EdgeInsets.only(left:11 ,right:11 ,top: 10,bottom: 5 ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: w/4,
                                        margin: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
                                        child:Image.network(snapshot.data!.docs[index1]['ImageProfile']),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10,right: 15,top: 10,bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(OrdarStat,style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold,color: Colors.white),),
                                            Text(snapshot.data!.docs[index1]['Name'],style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.bold),),
                                            Text(DateFormat.jm().format(DateTime.now()).toString(),style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                data[index1]['OrdarStates']>=4?
                                                ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)), child:
                                                const Text('😊  تقييم الطلب'),):
                                                ElevatedButton(onPressed: (){
                                                  print(data[index]['OrdarStates']);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                      OrdarShop(
                                                          TotalPrise:int.parse(data[index]['totalPrice'].replaceAll('₪', '')) ,
                                                          ordarId:data[index]['orderID'],),));
                                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child:
                                                Row(
                                                  children: [
                                                    Lottie.asset('assets/lottie/talabLocation.json',height: 25),
                                                    const Text('تتبع طلبك'),
                                                  ],
                                                ),),

                                                const SizedBox(width: 15,),
                                                ElevatedButton(onPressed: (){
                                                  showDialog(context: context, builder: (context) => AlertDialog(
                                                    content: Container(
                                                      height: 150,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          const Text('هل انت متأكد من اعادة الطلب؟'),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)), child: const Text('نعم'),),
                                                              ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)), child: const Text('لا'),),

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),);
                                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)), child: const Text('إعادة الطلب'),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),);
                          },
                        ),
                      );
                    },
                  ),
                );
              }

              return const CircularProgressIndicator(color: Colors.red,);
            },
          ),
        ],
      ),
    );
  }
}
/* */