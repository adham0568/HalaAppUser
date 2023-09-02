import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Support/FireBaseStatment.dart';
import 'package:halaapp/models/Support/SuppurtPage.dart';
import 'package:halaapp/models/Support/WaitingList.dart';
import 'package:halaapp/models/snack.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../provider/DataUser.dart';
import '../../../homepage.dart';

class OrdarShop extends StatefulWidget {
  double TotalPrise;
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
  Future<void> OrdarCance() async {
    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordar');
    Map<String, dynamic> OrdarDoneadd = {'OrdarStates':5,};
    listItem
        .doc('${widget.ordarId}')
        .update(OrdarDoneadd)
        .then((value) => showSnackBar(context: context, text: 'تم الغاء الطلب', color1: Colors.red))
        .catchError((error) => print("Failed to add order: $error"));
    print('تم تحديث الطلبات  الفاشلة');

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: h/3,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.grey),borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LottieBuilder.asset('${Images[NumImages!]}',height: h/4,),
                  Text(TextUnderImg,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 20),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2,color: Colors.grey)),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 50,),
                          Expanded(child: Text(DataUser!.Name,style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),)),
                          Text(": الاسم",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),),
                          SizedBox(width: 50,)
                        ],),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 50,),
                          Expanded(child: Text("(${City1[DataUser!.City]})",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),)),
                          Text(": المدينة",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),),
                          SizedBox(width: 50,)
                        ],),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 50,),
                          Expanded(child: Text("(${DataUser!.Dis})",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),)),
                          Text(": العنوان",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),),
                          SizedBox(width: 50,)
                        ],),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 50,),
                          Expanded(child: Text("${DataUser!.PhoneNumber}",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold,color: Colors.redAccent),)),
                          Text(": رقم الهاتف",style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold),),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: w*0.03),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      await DataBase.StartNewSupportOrdar(massege: 'مرحبا بك, كيف يمكننا مساعدتك ', Which: 1,Name: DataUser.Name);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingListSupport(),));
                    },
                    child: Container(
                      height: h/15,
                      width: w*0.45,
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
                        fontSize: w/20
                      ),)),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      //OrdarCance()
                      NumImages! == 0?
                          showDialog(context: context, builder: (context) => AlertDialog(
                            content: Container(
                              height: h/6,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('هل أنت متأكد من الغاء الطلب؟'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(onPressed: () {OrdarCance();Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);},
                                          child: Text('نعم'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),

                                        ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text('لا'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),)

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),)
                          :
                      showSnackBar(context: context, text: '  لا يمكن الغاء الطلب بعد البدء بتحضيره يمكنك التواصل مع الدعم', color1: Colors.teal);
                    },
                    child: Container(
                      height: h/15,
                      width: w*0.45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: NumImages! == 0? [
                              Colors.red,
                              Colors.pink
                            ]:[
                              Colors.black,
                              Colors.grey
                            ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text('الغاء الطلب',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: w/20
                      ),)),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


