import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../models/DiscountDesgin.dart';
import '../../../../models/Item.dart';
import '../../../../models/add.dart';
import '../Restaurant/AddPrudactToCart.dart';
import '../detalspage.dart';

class Offer extends StatefulWidget {
  int numberOfPage;
  List product;
  Offer({required this.numberOfPage,Key? key,required this.product}) : super(key: key);

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {

  List Tow=[];
  List PrudactData=[];
  bool dataTaken=false;
  GetDataListDiscount() {
    for (int i = 0; i < widget.product.length; i++) {
      if (widget.product[i]['Discount']*1.0 > 0) {
        PrudactData.add(widget.product[i]);
      }
    }
    setState(() {
      dataTaken = true;
    });
  }

  GetDataListMostPopular() {
    widget.product.sort((a, b) => Comparable.compare(b['Count_requests'], a['Count_requests']));
    for(int i=0;i<widget.product.length;i++)
    {
      PrudactData.add(widget.product[i]);
    }
    setState(() {
      dataTaken = true;
    });
  }

  @override
  void initState() {

    Tow=widget.product;
    print(widget.product);print('*************');
    widget.numberOfPage==0?GetDataListDiscount():GetDataListMostPopular();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return dataTaken? Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/Img/logowelcome.png',
          height: 100,
          color: Colors.white,
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
      body:  SingleChildScrollView(
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
                    PrudactData.length, (int index) {
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
                              PrudactData[index]['Opitions'].length>0?
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartResturant1(Prudact1: PrudactData[index] ))):
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detales(
                                        Prudact:PrudactData[index]
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
                                      PrudactData[index]['Discount']*1.0<1?
                                      PrudactData[index]['Discount']*1.0>0?
                                      const Text(''):const Text(''):const Text(''),
                                      Center(
                                        child: CachedNetworkImage(
                                          imageUrl: PrudactData[index]['ImageUrl'],
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
                                  Text(PrudactData[index]['Name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  const SizedBox(height: 5,),
                                  PrudactData[index]['Discount']*1.0>0?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:' ₪''${PrudactData[index]['Prise']*1.0-PrudactData[index]['Discount']*1.0} / ',
                                          style: TextStyle(fontSize:  w/18,color: Colors.red,fontWeight: FontWeight.bold,), // يمكنك استخدام أسلوب النص الافتراضي
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${PrudactData[index]['Prise']*1.0} ₪',
                                              style: TextStyle(decoration: TextDecoration.lineThrough,fontSize:  w/18,color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                      :
                                  Text('${PrudactData[index]['Prise']*1.0} ₪',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                  Container(decoration:
                                  BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(5)),
                                    child:PrudactData[index]['TybePrudact']<1?
                                    AddToCartWidget(Prudact: PrudactData[index],ColorIcon: Colors.teal,SizeIcon: 30,):
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartResturant1(Prudact1:  PrudactData[index],)));
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
                                  PrudactData[index]['Discount']*1.0>0?
                                  Container(
                                      width: w/5.8,
                                      child: DiscountWidget(Prise: PrudactData[index]['Prise']*1.0, Discount:PrudactData[index]['Discount']*1.0 , Size1: 10))
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
      )
    ):CircularProgressIndicator();
  }
}
/*
*/