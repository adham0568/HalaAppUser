import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
import 'package:halaapp/models/Adds/ModelApp.dart';
import 'package:provider/provider.dart';
import '../../../../provider/CartProvider.dart';
import 'CollectionPage.dart';

class SoparMarker extends StatefulWidget {
  const SoparMarker({Key? key}) : super(key: key);

  @override
  State<SoparMarker> createState() => _SoparMarkerState();
}
class _SoparMarkerState extends State<SoparMarker> {
  @override
  void initState() {
    GetDataFromFireBase();
    super.initState();
  }
  List images = [];
  bool waiting=false;

  Future<Map<String, dynamic>?> GetDataFromFireBase() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('Pohto add').doc('HomePage').get();

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
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);
    return waiting? Scaffold(
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
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(Name: "منتجات",whichPage: true,NamePrudact: ''),));
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20,right: 20),
                height:h/15 ,
                margin: EdgeInsets.only(left: w/10,right: w/10,top: w/20),
                decoration: BoxDecoration(
                  border: Border.all(width: 2,color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search_rounded,color: Colors.teal.withOpacity(0.9),),
                    Text('ابحث عن المنتجات هنا',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.teal.withOpacity(0.7)),)
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                child:ImageAnimation2(DocumantName: "E9gjtaIUHghyU0jneZZA")/*ImageAnimation(images: images)*/
              ),
            ),
            const SizedBox(height: 40,),
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Collection').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(left: 9,right: 9),
                height: h*0.75,
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

                    return SizedBox(
                      child:AnimationLimiter(
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: w*0.7/w*1,
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
                                            builder: (context) => CollectionPage(DataFromCollection: snapshot.data!.docs[index].data() as Map<dynamic, dynamic>,)));
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
              ),
            );
                  },
                ),
                const SizedBox(height: 50,)
              ],
            )
          ],
        ),
      ),
    ):Container(
        color: Colors.white,
        child: const Center(child: CircularProgressIndicator(),));
  }
}



 /*GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 7,mainAxisSpacing: 5,mainAxisExtent: 150),
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          splashColor: Colors.teal,
                          onTap: () {
                           // _Provaider.updateXID('C1zSXr7C9DW3MHN9tsbBiNRSu3g2');
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CollectionPage(DataFromCollection: data,)/*PrudactPage(DataFromeCollection: data,)*/));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(50, 50, 50, 10),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: data['ImageUrl'],
                                  placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 105,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                 Center(child: Text(data['Name'],style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.black),))
                              ],
                            ),
                          ),
                          );
                        }).toList(),
                      )*/