import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Support/FireBaseStatment.dart';
import 'package:halaapp/models/Support/SuppurtPage.dart';
import 'package:halaapp/models/Support/WaitingList.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../provider/DataUser.dart';
import '../../../homepage.dart';

class OrdarShop extends StatefulWidget {
  int TotalPrise;
  int ordarId;
  OrdarShop({Key? key,required this.TotalPrise,required this.ordarId}) : super(key: key);

  @override
  State<OrdarShop> createState() => _OrdarShopState();
}
List Images = [
  'assets/lottie/waiting.json',
  'assets/lottie/ordar acsept.json',
  'assets/lottie/cook.json',
  'assets/lottie/delivring.json',
  'assets/lottie/ORDERdONE.json',
  'assets/lottie/feildOrdar.json',
  'assets/lottie/cancel.json',
];
class _OrdarShopState extends State<OrdarShop> {
  List<String> City1 = [
    "الخليل",
    "نابلس",
    "طولكرم",
    "يطا",
    "جنين",
    "البيرة",
    "دورا",
    "رام الله",
    "الظاهرية",
    "قلقيلية",
    "بيت لحم",
    "طوباس",
    "سلفيت",
    "بيت جالا",
    'بيت ساحور'
  ];
  @override
  int? NumImages;
  String TextUnderImg='';
  firebaseStatment DataBase=firebaseStatment();
  DiscauntData() async {
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Ordar').doc('${widget.ordarId}').get();
        NumImages=snapshot.data()!['OrdarStates'];
    }
    catch(e){print(e);}
  }

  @override
  void initState() {
    DiscauntData();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      NumImages==4?timer.cancel():null;
      NumImages==5?timer.cancel():null;
      NumImages==6?timer.cancel():null;
      setState(() {
        DiscauntData();
      });
        NumImages==0?TextUnderImg="بانتظار قبول الطلب":null;
        NumImages==1?TextUnderImg="تم قبول الطلب":null;
        NumImages==2?TextUnderImg="يتم تجهيز الطلب":null;
        NumImages==3?TextUnderImg="الطلب في طريقه اليك":null;
        NumImages==5?TextUnderImg="تم الغاء الطلب 🥲":null;
        NumImages==6?TextUnderImg="تم رفض الطلب 🥲":null;
        if(NumImages==4){TextUnderImg=" 👌  صحتين وعافية";
        Timer.periodic(const Duration(seconds: 3), (timer) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
          timer.cancel();
        });
        }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final DataUser = Provider.of<Userdata>(context).getUser;

    return  NumImages==null?Container(color: Colors.white,child: const Center(child: SizedBox(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.yellow,)))):
    Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Img/logowelcome.png'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 281,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.grey),borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LottieBuilder.asset('${Images[NumImages!]}',height: 230,),
                Text(TextUnderImg,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 150,
            margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2,color: Colors.grey)),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50,),
                        Expanded(child: Text(DataUser!.Name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                        Text(": الاسم",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 50,)
                      ],),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50,),
                        Expanded(child: Text("(${City1[DataUser!.City]})",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                        Text(": المدينة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 50,)
                      ],),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50,),
                        Expanded(child: Text("(${DataUser!.Dis})",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                        Text(": العنوان",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 50,)
                      ],),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50,),
                        Expanded(child: Text("${DataUser!.PhoneNumber}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
                        Text(": رقم الهاتف",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 50,)
                      ],),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 78,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 16,right: 16,top: 3,bottom: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey,width: 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.TotalPrise} ₪',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                const Text('المبلغ الاجمالي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await DataBase.StartNewSupportOrdar(massege: 'مرحبا بك, كيف يمكننا مساعدتك ', Which: 1,Name: DataUser.Name);
              Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingListSupport(),));
            },
            child: Container(
              height: h/12,
              width: w*0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(56, 95, 172, 1),
                    Color.fromRGBO(1, 183, 168, 1)
                  ]
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('تواصل مع الدعم',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25
              ),)),
            ),
          )
        ],
      ),
    );
  }
}


