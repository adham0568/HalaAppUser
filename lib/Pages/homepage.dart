//Test GitUpdate
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/Shortcuts/PreviousOrders.dart';
import 'package:halaapp/Pages/appPages/Sections/MPB/MPB.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Restaurant%20List.dart';
import 'package:halaapp/Pages/AccountPages/AccountPage.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
import 'package:halaapp/models/Color.dart';
import 'package:halaapp/models/HIGHT.dart';
import 'package:halaapp/provider/DataUser.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/Adds/ModelApp.dart';
import '../models/Adds/ModelApp.dart';
import '../models/CartProvider.dart';
import '../models/snack.dart';
import '../provider/CartProvider.dart';
import '../provider/TotalPrudact.dart';
import 'appPages/Cart/CartPage.dart';
import 'appPages/Sections/Hala/SuperMarket.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
ColorModel CM=ColorModel();
String addName1='0';
String addName='0';
class _HomePageState extends State<HomePage> {

  bool? whichPage;
  String? Name;
  Map<String, dynamic> ? dataUser;
  static Map<String, dynamic> Data = {};

bool DataGett1=false;

  getDataFromDB() async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }
  @override
  void initState() {
    getDataFromDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      addName='HomePageAdd2';
      addName1='addName1';
    });
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final DataUser = Provider.of<Userdata>(context).getUser;
    final Provaider = Provider.of<CartProvider>(context);
    return
      DataUser==null?Container(color: CM.W1,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.teal,backgroundColor: Colors.red,),
        ),
      ): Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.teal.withOpacity(0.7),
                              Colors.teal.withOpacity(0.9)
                            ]
                        )
                    ),
                    child:FutureBuilder<DocumentSnapshot>(
                    future:FirebaseFirestore.instance.collection('Pohto add').doc('WelcomePage').get(),
                    builder:
                        (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                data['TybePrudact']==0?whichPage=true:whichPage=false;
                                data['TybePrudact']==0?Name='منتج':Name='مطعم';
                                return  Stack(
                                  children: [
                                    SafeArea(child: Image.asset('assets/Img/logowelcome.png',fit: BoxFit.cover,color: Colors.white.withOpacity(0.1),height: 700,width: 700,)),
                                    Container(
                                      margin: EdgeInsets.only(top: w/6,right: w/8),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(data['TextAdd'],style: TextStyle(color: CM.W1,fontWeight: FontWeight.bold,fontSize: h/35),)),
                                          Transform.translate(
                                            offset: Offset(w/2.8,w/7),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(whichPage: whichPage!, Name:Name!, NamePrudact: data['PrudactName']),));
                                              },
                                              child: Container(
                                                height: w/11,
                                                width: w/3,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: Colors.black,width: 0.5),
                                                  color:CM.W1,
                                                ),
                                                child: Center(child: Text('أطلب الان',style: TextStyle(fontSize: 15,color: Colors.teal,fontWeight: FontWeight.bold),)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Stack(
                                        children: [
                                          Image.asset('assets/Img/hooosadasda.png',height: h/5.5,),
                                          Positioned(
                                              left: w/13.3,
                                              child:Container(
                                                height:h/6,
                                                child: CachedNetworkImage(
                                                  imageUrl: data['ImageUrl'],
                                                  placeholder: (context, url) => Container(
                                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                                      height: h/8,width:h/8,child: const CircularProgressIndicator(color: Colors.red)),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              return Text("loading");
                              },
                    )
                  )
              ),
              leading:  Container(
                margin: EdgeInsets.all(w/75),
                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                child: Center(
                  child: IconButton(onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountPage(),));
                  },icon: const Icon(Icons.account_circle_outlined,color: Colors.black,size: 30,)),
                ),
              ),
              expandedHeight: h/3,
              pinned: true,
              backgroundColor: Colors.white,
              actions: [
                CartWidget(h: w*0.1, w: w*0.1)
              ],
            ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              return
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: h/12),
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
                                          decoration: BoxDecoration(color:CM.BackGround,borderRadius: BorderRadius.circular(12)),
                                          child: Image.asset('assets/Sections/4.png',),
                                        ),
                                      ),
                                      const Text('لحوم',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SuperMarket()));
                                  },
                                  child: Container(
                                    width: w/3.5,
                                    height: h/5.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                          child: Image.asset('assets/Sections/1.png',),
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
                                          child: Image.asset('assets/Sections/3.png',),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => MPB(Tybe: 10),));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                          child: Image.asset('assets/Sections/5.png',),
                                        ),
                                      ),
                                      const Text('مخبوزات',style: TextStyle(color: Colors.black,fontSize: 20),),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MPB(Tybe: 12),));
                                  },
                                  child: Container(
                                    width: w/3.5,
                                    height: h/5.5,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),
                                          child: Image.asset('assets/Sections/2.png',),
                                        ),
                                        const Text('صيدلية',style: TextStyle(color: Colors.black,fontSize: 20),),
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
                                          decoration: BoxDecoration(color: const Color.fromRGBO(230, 230, 230, 1),borderRadius: BorderRadius.circular(12)),//انشاء قسم القهوة
                                          child: Image.asset('assets/Sections/6.png',),
                                        ),
                                        const Text('قهوة',style: TextStyle(color: Colors.black,fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),/*القسم الثاني*/
                    const SizedBox(height: 70,),
                    Container(
                      margin: const EdgeInsets.only(left: 8,right:8 ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text('اختصارات',style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 25),),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  showSnackBar(context: context, text: 'سيتم توفير هذا الخيار قريباً', color1: CM.T1);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: h/8,
                                      width: w/5,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                          color: Colors.black54
                                      ),
                                      child: Icon(Icons.handshake,size: h/16,color: CM.W1,),
                                    ),
                                    const Text('أعمال الخير'),
                                  ],
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  showSnackBar(context: context, text: 'سيتم توفير هذا الخيار قريباً', color1: CM.T1);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: h/8,
                                      width: w/5,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                          color: Colors.black54
                                      ),
                                      child: Icon(Icons.food_bank_outlined,size: h/16,color: CM.W1,),
                                    ),
                                    const Text('اكيلة الشورما'),
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
                                          color: Colors.black54
                                      ),
                                      child: Icon(Icons.discount,size: h/16,color: CM.W1,),
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
                                        color: Colors.black54
                                      ),
                                      child: Icon(Icons.article_sharp,size: h/16,color: CM.W1,),
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
                    const SizedBox(height: 47,),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text('عروض',style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 25),),
                        ),
                        Center(
                          child: Container(
                              child:ImageAnimation(DocumantName:'HomePageAdd2')
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 47,
                    ),/*القسم الرابع*/
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text('جديد',style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 25),),
                        ),
                        Center(
                          child: Container(
                              child:ImageAnimation(DocumantName:'HomePage')
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 47,),
                  ],
                );
            },childCount:1 )),
          ],
        ),
      );
  }
}
