import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../Pages/appPages/Sections/detalspage.dart';
import 'DiscountDesgin.dart';
import 'add.dart';

class GridView2 extends StatefulWidget {
  String idMainCollection;
  List productData;
  GridView2({Key? key,required this.productData,required this.idMainCollection,}) : super(key: key);

  @override
  State<GridView2> createState() => _GridView2State();
}

class _GridView2State extends State<GridView2> {
  List productMarket=[];
  sortProduct(){
    for(int i=0;i<widget.productData.length;i++){
      if(widget.productData[i]['IdMainCollection']==widget.idMainCollection){
        productMarket.add(widget.productData[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    productMarket.clear();
    setState(() {
      sortProduct();
    });
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
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
                  productMarket.length, (int index) {
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
                                        Prudact:productMarket[index]
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
                                    productMarket[index]['Discount']*1.0>0?
                                    Container(
                                        width: w/5.8,
                                        child: DiscountWidget(Prise:productMarket[index]['Prise']*1.0, Discount:productMarket[index]['Discount']*1.0 , Size1: 10))
                                        :
                                    const Text(''),
                                    Container(
                                      margin: EdgeInsets.only(top: w/16),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: productMarket[index]['ImageUrl'],
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
                                    ),
                                  ],
                                ),
                                Text(productMarket[index]['Name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 5,),
                                productMarket[index]['Discount']*1.0>0?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:' ₪''${productMarket[index]['Prise']*1.0-productMarket[index]['Discount']*1.0} / ',
                                        style: TextStyle(fontSize: w/18,color: Colors.red,fontWeight: FontWeight.bold,), // يمكنك استخدام أسلوب النص الافتراضي
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '${productMarket[index]['Prise']*1.0} ₪',
                                            style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: w/18,color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                    //Text('${data[index]['Prise']*1.0-data[index]['Discount']*1.0}'+' ₪',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                )
                                    :
                                Text('${productMarket[index]['Prise']*1.0} ₪',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                Container(decoration: BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(5)),
                                    child: AddToCartWidget(Prudact:productMarket[index],ColorIcon: Colors.teal,SizeIcon: 30,)),
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
}



