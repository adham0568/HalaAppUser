import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Color.dart';

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
  ColorModel Cm=ColorModel();
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
          height: h,
          width: h,
          color: Colors.white70,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: w/10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15,),
                  Text('هلا ماركت',style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: w/15),),
                  SizedBox(width: w/10,),
                  Container(
                    width: w/3,
                    height: w/3,
                    margin: EdgeInsets.all(w/20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white
                    ,border: Border.all(color: Colors.black54,width: 2)),
                  child: Image.asset('assets/Img/logowelcome.png'),
                  ),

                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: w/20,right: w/20),
              padding: EdgeInsets.only(left: w/20,right: w/20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('    الاسم: ${DataUser!['Name']}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/20),),
                  Text('${DataUser!['PhoneNumber']}  :  رقم الهاتف',style:TextStyle(fontWeight: FontWeight.bold, fontSize: w/20),),
                  Text(' العنوان:${DataUser!['Dis']}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/20),),
                ],),
            ),
            Container(
              margin: EdgeInsets.all(w/45),
              padding: EdgeInsets.all(w/45),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black45,width: 2)),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(':الاصناف',style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/15),)),
                SizedBox(
                  height:displayedItems.length*h/4.2,
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
                          height: h/6,
                          margin: const EdgeInsets.all(5),
                          padding: EdgeInsets.only(left: w/30, right: w/30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Cm.Mix1,
                                    Cm.Mix2
                                  ])
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.white,width: 2)),
                                child: CachedNetworkImage(
                                  imageUrl: currentItem['ImageUrl'],
                                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.green),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  height: w/8,
                                ),
                              ),
                              Text(currentItem['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.white)),
                              Container(
                                height: w/6,
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(top: w/10,right: w/20,bottom:  w/20,left:  w/20),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: Colors.white)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('الكمية: $duplicateItemsCount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.white)),
                                    Text('${currentItem['Prise'] * duplicateItemsCount} ₪', style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/25, color: Colors.white)),
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
                Text('${TotalPrise.substring(0, TotalPrise.length - 1)}   :  السعر الاجمالي',style:TextStyle(fontWeight: FontWeight.bold, fontSize: w/15),),
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
