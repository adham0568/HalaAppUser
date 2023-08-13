//Test GitUpdate
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/Shortcuts/PreviousOrders.dart';
import 'package:halaapp/Pages/appPages/Sections/MPB/MPB.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Restaurant%20List.dart';
import 'package:halaapp/Pages/appPages/Sections/Hala/soprmarket.dart';
import 'package:halaapp/Pages/AccountPages/AccountPage.dart';
import 'package:halaapp/models/HIGHT.dart';
import 'package:halaapp/provider/DataUser.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/Adds/ModelApp.dart';
import '../provider/CartProvider.dart';
import '../provider/TotalPrudact.dart';
import 'appPages/Cart/CartPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Map<String, dynamic> ? dataUser;
  static Map<String, dynamic> Data = {};

bool DataGett1=false;

  getDataFromDB() async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  List images = [];
  bool waiting=false;

  Future<Map<String, dynamic>?> GetDataFromFireBase() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('Pohto add').doc('HomePageAdd1').get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        setState(() {
          images = data['Images']; // قم بتعيين القائمة images بقيمة images المسترجعة من Firestore
          waiting = true;
        });
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  @override
  void initState() {
    getDataFromDB();
    GetDataFromFireBase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final DataUser = Provider.of<Userdata>(context).getUser;
    final Provaider = Provider.of<CartProvider>(context);
    return
    DataUser==null?Container(color: Colors.white,
    child: const Center(
      child: CircularProgressIndicator(color: Colors.teal,backgroundColor: Colors.red,),
    ),
    ):
      Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () async {
              //signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountPage(),));
            },icon: const Icon(Icons.account_circle,color: Colors.white,)),
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
            actions: [
              SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                        top: 7,
                        left: 25,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(color: Color.fromRGBO(20, 20, 20, 200), shape: BoxShape.circle),
                          child: Center(child: Consumer<total>(
                            builder: (context, value, child) {
                              return Text(value.Num1().toString(),style: const TextStyle(fontSize: 15,color: Colors.black45),);
                            },
                          )),
                        )),
                    Positioned(
                        top: 10,
                        right: 10,
                        left: 10,
                        bottom: 10,
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
                        }, icon: const Icon(CupertinoIcons.cart,color: Colors.white,))),

                  ],
                ),
              )
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26,offset: Offset(10,10),blurRadius: 5,spreadRadius: 2)
                  ]
                  ),
                  width: SizeFix().wight(context: context)*0.98,
                  child: Column(
                    children: [
                      Container(
                        child: Lottie.asset('assets/lottie/wlecome.json'),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(DataUser.Name,style: const TextStyle(fontSize: 30,color: Colors.teal,fontFamily:'Name' ),),
                              const SizedBox(width: 5,),
                              const Text('يا هلا',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 47,),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: w/3.5,
                              height: h/5.5,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MPB(Tybe: 11),));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                      child: Image.asset('assets/parts/pngegg.png',height: 100,width: 121,),
                                    ),
                                  ),
                                  const Text('لحوم',style: TextStyle(color: Colors.black,fontSize: 20),),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SoparMarker()));
                              },
                              child: Container(
                                width: w/3.5,
                                height: h/5.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                      child: Image.asset('assets/parts/مارت.png',height: 100,width: 130,),
                                    ),
                                    const Text('سوبر ماركت',style: TextStyle(color: Colors.black,fontSize: 20),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantList(Which: false),));
                              },
                              child: Container(
                                width: w/3.5,
                                height: h/5.5,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                      child: Image.asset('assets/parts/طعام.png',height: 100,width: 121,),
                                    ),
                                    const Text('مطاعم',style: TextStyle(color: Colors.black,fontSize: 20),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.only(right: 9,left: 9),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MPB(Tybe: 10),));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                        child: Image.asset('assets/parts/مخبوزات.png',height: 100,width: 170,),
                                      ),
                                    ),
                                    const Text('مخبوزات',style: TextStyle(color: Colors.black,fontSize: 20),),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MPB(Tybe: 12),));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                        child: Image.asset('assets/parts/صيدلية.png',height: 100,width: 170,),
                                      ),
                                    ),
                                    const Text('صيدلية',style: TextStyle(color: Colors.black,fontSize: 20),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),/*القسم الثاني*/
                const SizedBox(height: 70,),
                Center(
                  child: Container(
                      child:ImageAnimation2( DocumantName:'HomePageAdd2')
                  ),
                ),
                const SizedBox(height: 47,),
                Container(
                  margin: const EdgeInsets.only(left: 8,right:8 ),
                  child: Column(
                    children: [
                      Transform.translate(offset: const Offset(150,0),
                          child: const Text('اختصارات',style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 25),)),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  height: h/8,
                                  width: w/5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(begin:Alignment.topLeft ,end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromRGBO(56, 95, 172, 1),
                                    Color.fromRGBO(1, 183, 168, 1)
                                  ])),
                                  child: Icon(Icons.handshake,size: h/16,color: Colors.white,),
                                ),
                                const Text('اعمال الخير'),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  height: h/8,
                                  width: w/5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(begin:Alignment.topLeft ,end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromRGBO(56, 95, 172, 1),
                                            Color.fromRGBO(1, 183, 168, 1)
                                          ])),
                                  child: Icon(Icons.hotel_class,size: h/16,color: Colors.white,),
                                ),
                                const Text('جديد'),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantList(Which: true),));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: h/8,
                                  width: w/5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(begin:Alignment.topLeft ,end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromRGBO(56, 95, 172, 1),
                                            Color.fromRGBO(1, 183, 168, 1)
                                          ])),
                                  child: Icon(Icons.discount,size: h/16,color: Colors.white,),
                                ),
                                const Text('العروض'),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PreviousOrdar(),));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: h/8,
                                  width: w/5,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(begin:Alignment.topLeft ,end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromRGBO(56, 95, 172, 1),
                                            Color.fromRGBO(1, 183, 168, 1)
                                          ])),
                                  child: Icon(Icons.article_sharp,size: h/16,color: Colors.white,),
                                ),
                                const Text('طلباتك السابقة'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),//اختصارات
                const SizedBox(
                  height: 100,
                 /* child: ListView.builder(
                    itemCount: ListOfProductskho.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return  Container(
                        margin: EdgeInsets.only(right: 9,left: 9),
                        decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(12)),
                        height: 340,
                        child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.asset('${ListOfProductskho[index].Image}',height: 100,width: 100,)),
                      );
                    },

                  ),*/
                ),/*القسم الرابع*/
              ],
            ),
          )
    );
  }
}
