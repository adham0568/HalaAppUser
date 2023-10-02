import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/AccountPages/AccountPage.dart';
import 'package:halaapp/Pages/LogInPage/AddLocation.dart';
import 'package:halaapp/Pages/appPages/Sections/ChackeOut/DoneOrdar.dart';
import 'package:halaapp/models/Notification.dart';
import 'package:halaapp/models/snack.dart';
import 'package:provider/provider.dart';

import '../../../../provider/CartProvider.dart';
import '../../../../provider/DataUser.dart';
import '../../../../provider/TotalPrudact.dart';

class ChackeOotPage extends StatefulWidget {
  const ChackeOotPage({Key? key}) : super(key: key);

  @override
  State<ChackeOotPage> createState() => _ChackeOotPageState();
}
class _ChackeOotPageState extends State<ChackeOotPage> {
  Future<void> DiscountEditing({required double DiscountNum}) async {
    print(DiscountNum);
    CollectionReference listItem = FirebaseFirestore.instance.collection('Discount');

    Map<String, dynamic> DiscountData = {
      'DiscountNum': DiscountNum-1,
    };

    listItem
        .doc(CodeDiscount.text)
        .update(DiscountData)
        .then((value) => print("Editing"))
        .catchError((error) => print("Failed to add order: $error"));

    print('تم تعديل حالة الطلب بنجاح في Firestore');
  }

  DiscauntData() async {
    try{DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Discount').doc(CodeDiscount.text).get();
    print('done');
    setState(() {
      if(snapshot.data()!['DiscountNum']==0){Discount=0;showSnackBar(context: context, text: 'الكود منتهي', color1: Colors.red);}
      else{Discount=snapshot.data()!['DiscountValue']*1.0;}
      DiscountNum=snapshot.data()!['DiscountNum']*1.0;
    });
    print(DiscountNum);
    }
    catch(e){
      setState(() {
        Discount=0;
      });
      print(e);}
  }
  @override
  final CodeDiscount=TextEditingController();
  double? Discount;
  double?DiscountNum;
  double? _TotalPrise;
  int? IdOrdar;
  int ordarid(){
   return IdOrdar= Random().nextInt(1000000);
  }

  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    final Provaider = Provider.of<CartProvider>(context);
    final ProvaiderTotalPrudact = Provider.of<total>(context);
    int IdOrdar=ordarid();
    int OrdarId1=IdOrdar;
    Future<void> sendListToFirestore() async {
      double calculateTotalPrice() {
        double totalPrice = _TotalPrise!;
        for (var item in Provaider.listitem()) {
          totalPrice = _TotalPrise!;
        }
        return totalPrice;
      }
      CollectionReference listItem = FirebaseFirestore.instance.collection('Ordar');

      List<Map<String, dynamic>> formattedList = [];

      for (var item in Provaider.Products) {
        Map<String, dynamic> formattedItem = {
          'Name': item.Name,
          //'IdCollection': item.IdCollection,
          'IdMainCollection': item.IdMainCollection,
          'IdPrudact': item.IdPrudact,
          'ImageUrl': item.ImageUrl,
          'PrudactsDetals': item.PrudactsDetals,
          'Prise': item.Prise,
          'Opitions':item.Opitions,
          'TybePrudact':item.TybePrudact,
          'IdUser':FirebaseAuth.instance.currentUser!.uid,
          'OpitionSelected':item.OpitionSelected,
          'IdMarket':item.IdMarket,
          'Discount':item.Discount,
          'TybePrudact':item.TybePrudact,
          'Count_Quantity':item.Count_Quantity,
          'Count_requests':item.Count_requests,
        };

        formattedList.add(formattedItem);
      }

      String totalPrice = '$_TotalPrise ₪'; // قم بتعيين السعر الإجمالي الخاص بك هنا
      setState(() {
        Provaider. PirseCalculating()>100?_TotalPrise= Provaider. PirseCalculating() + 0 - Discount!:_TotalPrise= Provaider. PirseCalculating() + 7 - Discount!;
      });
      Map<String, dynamic> orderData = {
        'orderID': IdOrdar,
        'UserLat':DataUser!.Lat,
        'UserLng':DataUser!.Long,
        'totalPrice': '${calculateTotalPrice()} ₪',
        'items': formattedList,
        'OrdarStates': 0,
        'User':DataUser!.Uid,
        'UidMarket':Provaider.xid1,
        'DateTime':DateTime.now(),
        'OrdarRate':0,
        'NameUser':DataUser!.Name,
      };

      listItem
          .doc('$IdOrdar')
          .set(orderData)
          .then((value) => print("Order Added"))
          .catchError((error) => print("Failed to add order: $error"));

      print('تم إرسال القائمة والبيانات الإضافية بنجاح إلى Firestore');
    }
    Discount==null?Discount=0:Discount=Discount;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/Img/logowelcome.png',
          height: 100,
          color: Colors.white,
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Stack(
                    children: [
                      AddLocation(WhichPage: false),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountPage(),));
                        },
                        child: Container(
                          height: h/20,
                          width: w/4,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.purple,
                              Colors.red
                            ]
                          )),
                          child: const Center(child: Text('تعديل العنوان',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                        ),
                      )
                    ],
                  )),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 3),borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(12) ,bottomRight: Radius.circular(12))),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DataUser!.PhoneNumber,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              const Text('رقم الهاتف',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)), ],),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30,right: 30),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(DataUser.Name,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                               const Text('الاسم',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)), ],),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30,right: 30),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Expanded(child: Text(DataUser.Dis,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                            const Text('العنوان',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),],),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ), //Address
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.only(left: 15,right: 15),
              height: 51,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'وقت التوصيل 20 دقيقة',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.delivery_dining,size: 30,),
                ],
              ),
            ),//Time
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'طريقة الدفع',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: 51,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("الدفع نقداً",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(color: Colors.green,shape: BoxShape.circle,border: Border.all(color: Colors.grey,width: 0.5)),
                      child: const Center(child: Icon(Icons.check,color: Colors.white,),),
                    )
                  ],
                ),
              ),
            ), //Cash
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'وفر على طلبك',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: w/4,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: TextButton(
                          onPressed: () async {
                            setState(() {
                              DiscauntData();
                            });
                          },
                          child: Text(
                            'أرسال',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: w/25),
                          ))),
                  SizedBox(
                      height: w/5,
                      width: w/1.5,
                      child: TextField(
                        controller: CodeDiscount,
                        maxLength: 7,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ادخل كود الخصم',
                          hintStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                        ),
                      )
                  ),
                ],
              ),
            ), //CideDiscaunt
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ملخص الدفع',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Provaider. PirseCalculating()} ₪',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Text(
                        'سعر الطلب',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Provaider. PirseCalculating()>100?'0 ₪':'7 ₪',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Text(
                        'رسوم التوصيل',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0 ₪',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      Text(
                        'رسوم الخدمة',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$Discount ₪',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Text(
                        'الخصم',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Provaider. PirseCalculating()>100?Provaider. PirseCalculating() + 0 - Discount!:Provaider. PirseCalculating() + 7 - Discount!} ₪',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Text(
                        'المبلع الاجمالي',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                Notificasion().sendNotificationUsingServerToken(title: "Admin Hala", body: 'لديك طلب جديد', Token: Provaider.token);
               await sendListToFirestore();
                setState(() {
                  Provaider. PirseCalculating()>100?_TotalPrise= Provaider. PirseCalculating() + 0 - Discount! :_TotalPrise= Provaider. PirseCalculating() + 7 - Discount!;
                });
             await  Provaider.Clear();
               ProvaiderTotalPrudact.Clear();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OrdarShop(TotalPrise: _TotalPrise!,ordarId: OrdarId1,)));

               DiscountNum!<=0?null:DiscountEditing(DiscountNum: DiscountNum!);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(56, 95, 172, 1),
                          Color.fromRGBO(1, 183, 168, 1)
                        ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 110),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const Text(
                      'تنفيذ الطلب',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 110),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
