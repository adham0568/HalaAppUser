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
  GridViewRust({super.key, required this.Prudact,required this.Swich,required this.Uid});
  @override
  Widget build(BuildContext context) {

    double hight= MediaQuery.of(context).size.height;
    double wight= MediaQuery.of(context).size.width;
    int columnCount = 3;
    return FutureBuilder(
      future:Swich? FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdCollection', isEqualTo:Prudact['IdCollection'])
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
                      childAspectRatio:60/70,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(wight / 60),
                      crossAxisCount: 2,
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
                                          const Row(children: [
                                            Icon(CupertinoIcons.gift,size: 15,color: Colors.teal),
                                            Text('خصم',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.teal),),
                                          ],):const Text(''):const Text(''),
                                          Center(
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.docs[index]['ImageUrl'],
                                              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: 125,
                                                width: 140,
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
                                          Positioned(
                                              bottom: 2,
                                              left: 25,
                                              child:Container(decoration: BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(5)),
                                                  child:snapshot.data!.docs[index]['TybePrudact']<1? AddToCartWidget(Prudact:snapshot.data.docs[index].data(),ColorIcon: Colors.teal,SizeIcon: 30,):
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
                                              )
                                          )
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
                                              style: const TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold,), // يمكنك استخدام أسلوب النص الافتراضي
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${snapshot.data!.docs[index]['Prise']} ₪',
                                                  style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 25,color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          )
                                          //Text('${snapshot.data!.docs[index]['Prise']-snapshot.data!.docs[index]['Discount']}'+' ₪',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                        ],
                                      )
                                          :
                                      Text('${snapshot.data!.docs[index]['Prise']} ₪',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                      snapshot.data!.docs[index]['Discount']>0?
                                      Container(
                                          width: wight/5.8,
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



