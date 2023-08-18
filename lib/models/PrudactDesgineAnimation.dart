import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../Pages/appPages/Sections/detalspage.dart';
import 'DiscountDesgin.dart';
import 'add.dart';

class GridView2 extends StatelessWidget {
  Map Prudact;
  GridView2({super.key, required this.Prudact});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdMainCollection', isEqualTo:Prudact['IdPrudactMainCollection'])
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
                      childAspectRatio: h*3.5/w*0.1,
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
                                                    child: AddToCartWidget(Prudact:snapshot.data.docs[index].data(),ColorIcon: Colors.teal,SizeIcon: 30,))
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
                ),
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}



