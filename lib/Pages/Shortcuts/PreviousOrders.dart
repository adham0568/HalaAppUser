import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/AccountPages/FireBaseStatment.dart';
import 'package:halaapp/Pages/Shortcuts/PreviousOrdarDetales.dart';
import 'package:halaapp/Pages/appPages/Cart/CartPage.dart';
import 'package:halaapp/Pages/appPages/Sections/ChackeOut/ChackeOutPage.dart';
import 'package:halaapp/Pages/appPages/Sections/ChackeOut/DoneOrdar.dart';
import 'package:halaapp/models/Rating/Rating.dart';
import 'package:halaapp/models/Support/FireBaseStatment.dart';
import 'package:halaapp/models/snack.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/Item.dart';
import '../../models/Rating/FireBaseStatment.dart';
import '../../provider/CartProvider.dart';
import '../../provider/DataUser.dart';
import '../../provider/TotalPrudact.dart';


class PreviousOrdar extends StatefulWidget {
  const PreviousOrdar({Key? key}) : super(key: key);

  @override
  State<PreviousOrdar> createState() => _PreviousOrdarState();
}
class _PreviousOrdarState extends State<PreviousOrdar> {
  final Comment=TextEditingController();
  String OrdarStat='';
  DataBaseRate DbEdit=DataBaseRate();
  Item? myItems;
  List<Item> ItemsList=[];
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    final _Provaider = Provider.of<CartProvider>(context);
    final _Provaider1 = Provider.of<total>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    reOrdar({required List ItemList,required int index,required String idMarket}){
      _Provaider.xid1=idMarket;
      for(int i=0;i<ItemList.length;i++)
      {
        setState(() {
          myItems= Item(
            Count_Quantity:ItemList[i]['Count_Quantity'] ,
            Count_requests: ItemList[i]['Count_requests'],
            IdMainCollection:ItemList[i]['IdMainCollection'],
            IdPrudact: ItemList[i]['IdPrudact'],
            OpitionSelected: ItemList[i]['OpitionSelected'],
            Name: ItemList[i]['Name'],
            TybePrudact: ItemList[i]['TybePrudact'],
            Opitions: ItemList[i]['Opitions'],
            Prise: ItemList[i]['Prise'],
            Discount: ItemList[i]['Discount'],
            IdMarket: ItemList[i]['IdMarket'],
            ImageUrl: ItemList[i]['ImageUrl'],
            PrudactsDetals: ItemList[i]['PrudactsDetals'],
          );
        });
        print(_Provaider.IdPrudacts);
        setState(() {
          _Provaider.AddToCart(item:myItems!);
          _Provaider1.addNum();
        });
      }
    }
    return Scaffold(
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
      body: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('Ordar').where('User', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy('DateTime', descending: true)
                .limit(10)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                return SizedBox(
                  height: h*0.8,
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
                                  height: h/5,
                                  margin: const EdgeInsets.only(left:11 ,right:11 ,top: 10,bottom: 5 ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Image.network(snapshot.data!.docs[index1]['ImageProfile'])),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10,right: 15,top: 10,bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(OrdarStat,style: TextStyle(fontSize: w/25,fontWeight: FontWeight.bold,color: Colors.white),),
                                            Text(snapshot.data!.docs[index1]['Name'],style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.bold),),
                                            Text(DateFormat.jm().format(data[index]['DateTime'].toDate()).toString(),style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                data[index]['OrdarStates']>=4?
                                                InkWell(
                                                  onTap: () {
                                                    data[index]['OrdarRate']==0? showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor: Color.fromRGBO(100, 0, 0, 500),
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return Container(
                                                          color: Colors.white,
                                                          padding: EdgeInsets.only(left: w/20,right: w/20),
                                                          height: h/2.5,
                                                          child: Column(
                                                            children: [
                                                              Text('الرجاء تقييم الطلب',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/20),),
                                                              Raiting(SizeStar: 40),
                                                              TextFormField(
                                                                controller: Comment,
                                                                decoration: InputDecoration(border: OutlineInputBorder()),
                                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black54),
                                                                maxLength: 100,
                                                              ),
                                                              SizedBox(height: w/10,),
                                                              InkWell(
                                                                onTap: () async {
                                                                  DbEdit.Rateing(
                                                                      RateStars: Rate,
                                                                      Comment: Comment.text,
                                                                      Name: DataUser!.Name,
                                                                      Date: DateTime.now(),
                                                                      IdMarket:  data[index]['UidMarket'],
                                                                      idRating:Uuid().v1(),
                                                                      IdOrdar: data[index]['orderID'],
                                                                  );
                                                                  Navigator.pop(context);
                                                                  showSnackBar(context: context, text: 'تم ارسال التقييم', color1: Colors.teal);
                                                                  setState(() {});
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    gradient: LinearGradient(
                                                                      begin: Alignment.topRight,
                                                                      end: Alignment.bottomLeft,
                                                                      colors: [
                                                                        Colors.teal,
                                                                        Colors.tealAccent
                                                                      ]
                                                                    )
                                                                  ),
                                                                  width: w/2,
                                                                  height: w/9,
                                                                  child: Center(child:
                                                                    Text('إرسال',style: TextStyle(
                                                                      fontSize: 20,fontWeight: FontWeight.bold,
                                                                      color: Colors.white
                                                                    ),),),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ); },):showSnackBar(context: context, text: 'لا يمكن تقييم هذا الطلب مرة اخرى', color1: Colors.teal);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
                                                    width: w/5,
                                                    height: w/13,
                                                    child: Center(
                                                      child: Text('تقييم الطلب',style: TextStyle(
                                                          fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black
                                                      ),),
                                                    ),
                                                  ),
                                                ):
                                                ElevatedButton(onPressed: (){
                                                  print(data[index]['OrdarStates']);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                      OrdarShop(
                                                          TotalPrise:double.parse(data[index]['totalPrice'].replaceAll('₪', '')) ,
                                                          ordarId:data[index]['orderID'],),));
                                                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child:
                                                Row(
                                                  children: [
                                                    Lottie.asset('assets/lottie/talabLocation.json',height: 25),
                                                    const Text('تتبع طلبك'),
                                                  ],
                                                ),),

                                                const SizedBox(width: 15,),
                                                data[index]['OrdarStates']>=4?
                                                InkWell(
                                                  onTap: () {
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
                                                                InkWell(
                                                                  onTap: () async {
                                                                    Navigator.pop(context);
                                                                   await reOrdar(index: index,ItemList: data[index]['items'],idMarket:data[index]['UidMarket']);
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
                                                                    },
                                                                  child: Container(
                                                                    height: w/10,
                                                                    width: w/4,
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                                    gradient: LinearGradient(
                                                                      begin: AlignmentDirectional(5,2),
                                                                      end: Alignment.bottomLeft,
                                                                      colors: [
                                                                        Colors.tealAccent,
                                                                        Colors.teal,
                                                                      ]
                                                                    )
                                                                    ),
                                                                    child: Center(
                                                                      child: Text('نعم',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    height: w/10,
                                                                    width: w/4,
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                                        gradient: LinearGradient(
                                                                            begin: AlignmentDirectional(5,2),
                                                                            end: Alignment.bottomLeft,
                                                                            colors: [
                                                                              Colors.tealAccent,
                                                                              Colors.teal,
                                                                            ]
                                                                        )
                                                                    ),
                                                                    child: Center(
                                                                      child: Text('لا',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
                                                    width: w/5,
                                                    height: w/13,
                                                    child: Center(
                                                      child: Text('إعادة الطلب ',style: TextStyle(
                                                        fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black
                                                      ),),
                                                    ),
                                                  ),
                                                ):Text('')
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
/*if(_Provaider.Products.isNotEmpty){
            if(_Provaider.Products.first.IdMarket==myItems!.IdMarket){
              _Provaider.addPrudact(item: myItems!);
              print(_Provaider.IdPrudacts);
              _Provaider1.addNum();
              setState(() {
                _Provaider.AddToCart(item: myItems!);
              });
              _Provaider.GetNumberByProducts(myItems!) + 1;
            }
            else if(_Provaider.Products.first.IdMarket!=myItems!.IdMarket){
              showDialog(context: context, builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: 160,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('بدء سلة جديدة؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
                      const Text('عند بدء طلب من متجر جديد سيتم ازالة المنتجات من المتاجر الاخرى',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.black54),),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: (){
                            _Provaider.Products.clear();
                            _Provaider.listitem().clear();
                            _Provaider.xid1=myItems!.IdMarket;
                            _Provaider.addPrudact(item: myItems!);
                            print(_Provaider.xid1);
                            _Provaider1.addNum();
                            setState(() {
                              _Provaider.AddToCart(item: myItems!);
                            });
                            _Provaider.GetNumberByProducts(myItems!) + 1;
                            _Provaider1.Num=1;
                            Navigator.pop(context);
                          },
                              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal),overlayColor: MaterialStateProperty.all(Colors.red)), child: const Text('تأكيد البدء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                          ElevatedButton(onPressed: (){Navigator.pop(context);},
                              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),overlayColor: MaterialStateProperty.all(Colors.green)), child: const Text('الغاء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),);
            }
          }
          else{
            _Provaider.addPrudact(item: myItems!);
            _Provaider.xid1=myItems!.IdMarket;
            print(_Provaider.xid1);
            _Provaider1.addNum();

            setState(() {
              _Provaider.AddToCart(item: myItems!);
            });
            _Provaider.GetNumberByProducts(myItems!) + 1;

          } */