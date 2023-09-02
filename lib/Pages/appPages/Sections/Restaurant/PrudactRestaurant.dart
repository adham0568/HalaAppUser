import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/AddPrudactToCart.dart';

import '../../../../models/DiscountDesgin.dart';
import '../../../../models/add.dart';
import '../detalspage.dart';


class GridViewRust extends StatelessWidget {
  Map Prudact;
  bool Swich;
  String Uid;
  bool WhichPage;
  GridViewRust({super.key, required this.Prudact,required this.Swich,required this.Uid,required this.WhichPage});
  @override
  Widget build(BuildContext context) {

    double h= MediaQuery.of(context).size.height;
    double w= MediaQuery.of(context).size.width;
    int columnCount = 3;
    return FutureBuilder(
      future:
      WhichPage?
      FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdMarket', isEqualTo: Uid)
          .where('Count_requests',isGreaterThan: 10)
          .orderBy('Count_requests')
          .get()
          :
      Swich? FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdMainCollection', isEqualTo:Prudact['IdPrudactMainCollection'])
          .get()
          :
      FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdMarket', isEqualTo: Uid)
          .where('Discount',isGreaterThan: 0)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                  child:AnimationLimiter(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(w / 60),
                      crossAxisCount: 2,
                      childAspectRatio: h*4/w*0.1,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        snapshot.data!.docs.length, (int index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: 2,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            scale: 1.5,
                            child: FadeInAnimation(
                              child: InkWell(
                                borderRadius:BorderRadius.circular(15),
                                onTap: (){
                                  snapshot.data.docs[index]['Opitions'].length>=1?
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartResturant1(Prudact1: snapshot.data.docs[index].data()))):
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detales(
                                            Prudact:snapshot.data!.docs[index].data()!.map((key, value) => MapEntry(key, value)),
                                          )));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.teal,width: 3)),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          snapshot.data!.docs[index]['Discount']<1?
                                          snapshot.data!.docs[index]['Discount']>0?
                                          const Text(''):const Text(''):const Text(''),
                                          Center(
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.docs[index]['ImageUrl'],
                                              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: w/5,
                                                width: w/5,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                      const SizedBox(height: 5,),
                                      snapshot.data!.docs[index]['Discount']>0?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text:' ₪''${snapshot.data!.docs[index]['Prise']-snapshot.data!.docs[index]['Discount']} / ',
                                              style: TextStyle(fontSize:  w/18,color: Colors.red,fontWeight: FontWeight.bold,), // يمكنك استخدام أسلوب النص الافتراضي
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${snapshot.data!.docs[index]['Prise']} ₪',
                                                  style: TextStyle(decoration: TextDecoration.lineThrough,fontSize:  w/18,color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          )
                                          //Text('${snapshot.data!.docs[index]['Prise']-snapshot.data!.docs[index]['Discount']}'+' ₪',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      )
                                          :
                                      Text('${snapshot.data!.docs[index]['Prise']} ₪',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                      Container(decoration:
                                      BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(5)),
                                        child:snapshot.data!.docs[index]['TybePrudact']<1?
                                        AddToCartWidget(Prudact:snapshot.data.docs[index].data(),ColorIcon: Colors.teal,SizeIcon: 30,):
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartResturant1(Prudact1: snapshot.data.docs[index].data())));
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5)),
                                              height: 35,
                                              width:  35,
                                              child:Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color:Colors.teal,
                                                  size:30,
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: w/30),
                                      snapshot.data!.docs[index]['Discount']>0?
                                      Container(
                                          width: w/5.8,
                                          child: DiscountWidget(Prise:  snapshot.data!.docs[index]['Prise'], Discount:snapshot.data!.docs[index]['Discount'] , Size1: 10))
                                          :
                                      const Text(''),
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
                )
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}



