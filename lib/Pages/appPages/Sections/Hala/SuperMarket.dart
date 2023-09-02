import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Discount.dart';
import 'package:halaapp/models/Adds/ModelApp.dart';
import 'package:provider/provider.dart';
import '../../../../models/Adds/ModelApp.dart';
import '../../../../models/CartProvider.dart';
import '../../../../models/Color.dart';
import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';
import '../../../homepage.dart';
import '../../Cart/CartPage.dart';
import '../SearchPage.dart';
import 'CollectionPage.dart';

class SuperMarket extends StatefulWidget {
  const SuperMarket({Key? key}) : super(key: key);

  @override
  State<SuperMarket> createState() => _SuperMarketState();
}

class _SuperMarketState extends State<SuperMarket> {
  ColorModel CM=ColorModel();
  int Length=0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      addName="E9gjtaIUHghyU0jneZZA";
    });
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);
    return  Scaffold(
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
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: w/5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(Name: "منتجات",whichPage: true,NamePrudact: ''),));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            height:h/15 ,
                            width: w*0.8,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2,color: CM.W1),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.search_rounded,color:CM.W1,),
                                Text('ابحث عن المنتجات هنا',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CM.W1),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: w/18,),
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              splashColor: CM.T1,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Discaount(UidAdmin: 'C1zSXr7C9DW3MHN9tsbBiNRSu3g2',which_Page: false),));
                              },
                              child: Container(width: w*0.45,
                                height: w*0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:CM.b3,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('العروض',style: TextStyle(fontWeight: FontWeight.bold,color: CM.W1),),
                                    Icon(Icons.percent,color: CM.W1,)
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: CM.T1,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Discaount(UidAdmin: 'C1zSXr7C9DW3MHN9tsbBiNRSu3g2',which_Page: true),));

                              },
                              child: Container(width: w*0.45,
                                height: w*0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:CM.b3,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('🔥 الأكثر رواجاً',style: TextStyle(fontWeight: FontWeight.bold,color: CM.W1),),
                                    Icon(Icons.trending_up,color: CM.W1,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            expandedHeight: h/3,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            actions: [
              CartWidget(h: w*0.1, w: w*0.1)
            ],
            title:Text('Hala Market',style: TextStyle(fontWeight: FontWeight.w500,color: CM.W1,fontSize: 20),),
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Column(
                  children: [

                    Center(
                      child: Container(
                          child:ImageAnimation(DocumantName: addName)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Align(alignment: Alignment.topRight,
                            child: Text('تسوق حسب الصنف',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('Collection').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading");
                            }

                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.only(left: 9,right: 9),
                              width: w*0.95,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('Collection').where('UidAdmin',isEqualTo: 'C1zSXr7C9DW3MHN9tsbBiNRSu3g2').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Text("Loading");
                                  }
                                  Length=snapshot.data!.size;
                                  return SizedBox(
                                    child:AnimationLimiter(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        childAspectRatio:w*0.6/w*1,
                                        crossAxisSpacing: 0,
                                        physics:const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(left: w / 60,right: w / 60,bottom: w / 60 ,top: w / 60 ),
                                        crossAxisCount: columnCount,
                                        children: List.generate(
                                          snapshot.data!.size,
                                              (int index) {
                                            return AnimationConfiguration.staggeredGrid(
                                              position: index,
                                              duration: const Duration(milliseconds: 500),
                                              columnCount: columnCount,
                                              child: ScaleAnimation(
                                                duration: const Duration(milliseconds: 900),
                                                curve: Curves.fastLinearToSlowEaseIn,
                                                scale: 1.5,
                                                child: FadeInAnimation(
                                                  child: InkWell(
                                                    borderRadius: BorderRadius.circular(12),
                                                    splashColor: Colors.teal,
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => CollectionPage(DataFromCollection: snapshot.data!.docs[index]['IdCollection'],documents: snapshot.data!.docs,)));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: w / 15, left: w / 60, right: w / 60),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black.withOpacity(0.3),
                                                              blurRadius: 5,
                                                              spreadRadius: 2,
                                                              offset: const Offset(5,2)
                                                          ),
                                                        ],
                                                      ),
                                                      child:Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.all(5),
                                                            height: 100,
                                                            width: 100,
                                                            child: CachedNetworkImage(
                                                              imageUrl: snapshot.data!.docs[index]['ImageUrl'],fit: BoxFit.fill,
                                                              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                              imageBuilder: (context, imageProvider) => Container(
                                                                height: 110,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  image: DecorationImage(
                                                                    image: imageProvider,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(child: Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black),))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
