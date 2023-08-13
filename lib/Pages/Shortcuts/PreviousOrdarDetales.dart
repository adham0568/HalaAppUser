import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviousOrdarDetales extends StatefulWidget {
  final QueryDocumentSnapshot data;

  const PreviousOrdarDetales({Key? key,required this.data}) : super(key: key);

  @override
  State<PreviousOrdarDetales> createState() => _PreviousOrdarDetalesState();
}
class _PreviousOrdarDetalesState extends State<PreviousOrdarDetales> {
  @override
  Map? DataUser;
  bool DataGet=false;
    GetDataUser() async {
     await FirebaseFirestore.instance.collection('UserData')
          .doc(widget.data['User'])
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          // البيانات موجودة
          Map<String, dynamic> dataUser = snapshot.data() as Map<String, dynamic>;
          DataUser=dataUser;
          print(DataUser!);
          Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              DataGet=true;
            });
            timer.cancel();
          });
        } else {
          print("Document does not exist");
        }
      })
          .catchError((error) {
        print("Error retrieving data: $error");
      });
    }

  @override
  void initState() {
    GetDataUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String TotalPrise=widget.data['totalPrice'];

    List<dynamic> displayedItems = [];
    for (var item in widget.data['items']) {
      var isItemDisplayed = displayedItems
          .where((displayedItem) => displayedItem['IdPrudact'] == item['IdPrudact'])
          .isEmpty;
      if (isItemDisplayed) {
        displayedItems.add(item);
      }
    }

    return DataGet?Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text('رقم الطلب : ${widget.data['orderID'].toString()}',style: const TextStyle(fontWeight: FontWeight.bold,
            fontSize: 30),)),
            Container(
              margin: const EdgeInsets.only(left: 40,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15,),
                  const Text('هلا ماركت',style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 35),),
                  const SizedBox(width: 30,),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white
                    ,border: Border.all(color: Colors.black54,width: 3)),
                  child: Image.asset('assets/Img/logowelcome.png'),
                  ),

                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 15,right: 15),
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${DataUser!['Name']}  :  الاسم',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  Text('${DataUser!['EmailAddress']}  :  رقم الهاتف',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  Text('${DataUser!['EmailAddress']}  :  العنوان',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ],),
            ),



            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black45,width: 3)),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(':الاصناف',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                Text('${TotalPrise.substring(0, TotalPrise.length - 1)}   :  السعر الاجمالي',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                SizedBox(
                  height: widget.data['items'].length*70.0,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.data['items'].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var currentItem = widget.data['items'][index];

                      // فحص ما إذا تم عرض المنتج بالفعل
                      var isProductDisplayed = false;
                      for (int i = 0; i < index; i++) {
                        if (widget.data['items'][i]['IdPrudact'] == currentItem['IdPrudact']) {
                          isProductDisplayed = true;
                          break;
                        }
                      }

                      if (!isProductDisplayed) {
                        // حساب عدد المنتجات المتكررة للمنتج الحالي
                        var duplicateItemsCount = widget.data['items']
                            .where((item) => item['IdPrudact'] == currentItem['IdPrudact'])
                            .length;

                        return Container(
                          height: 120,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(56, 95, 172, 1),
                                    Color.fromRGBO(1, 183, 168, 1)
                                  ])
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.white,width: 3)),
                                child: CachedNetworkImage(
                                  imageUrl: currentItem['ImageUrl'],
                                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.green),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              Text(currentItem['Name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(top: 30,right: 15,bottom: 15,left: 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(width: 3,color: Colors.white)),
                                child: Column(
                                  children: [
                                    Text('الكمية: $duplicateItemsCount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                                    Text('${currentItem['Prise'] * duplicateItemsCount} ₪', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],),
            )
          ],
        ),
      ),
    ):
    Container(
        color: Colors.white,
        child: const Center(child: SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.yellowAccent,strokeWidth: 10,))));
  }
}
