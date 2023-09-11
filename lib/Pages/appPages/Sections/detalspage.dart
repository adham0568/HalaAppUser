import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/CartProvider.dart';
import 'package:halaapp/models/DiscountDesgin.dart';
import 'package:halaapp/models/HIGHT.dart';
import 'package:provider/provider.dart';
import '../../../models/add.dart';
import '../../../provider/TotalPrudact.dart';
import '../Cart/CartPage.dart';


//Use In Restaurant And Hala
class Detales extends StatefulWidget {
  final Map Prudact;



 const Detales({super.key, required this.Prudact});

  @override
  State<Detales> createState() => _DetalesState();
}
bool discounts=false;

class _DetalesState extends State<Detales> {
  @override
  void initState() {
    widget.Prudact['Discount']*1.0>0?discounts=true:discounts=false;
    // TODO: implement initState
    super.initState();
  }
  @override

  SizeFix SizeQ=SizeFix();
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: SafeArea(
                child: Container(
                  height:342 ,
                  width:double.infinity,
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.15)),
                  child:Center(
                    child: Stack(
                      children: [
                        Positioned(
                            top: 15,
                            left: 10,
                            child: CartWidget(h:SizeQ.wight(context: context)*0.1 ,w:SizeQ.wight(context: context)*0.1 ,)),
                        Positioned(
                            top: 15,
                            right: 10,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {Navigator.pop(context);},
                              child: Container(
                                height: SizeQ.wight(context: context)*0.1,
                                width: SizeQ.wight(context: context)*0.1,
                                decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 10,
                                          blurStyle: BlurStyle.normal,
                                          spreadRadius: 0.01,
                                          offset: Offset(3,4)
                                      )
                                    ]
                                ),
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Icon(
                                    Icons.close_sharp,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            )),
                        Stack(
                          children: [
                            Center(
                                child: CachedNetworkImage(
                                  height: SizeQ.Hight(context: context)*0.4,
                                  width: SizeQ.wight(context: context)*0.7,
                                  imageUrl: widget.Prudact['ImageUrl'],
                                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                            ),
                            Positioned(
                              //SizeQ.wight(context: context)*0.7
                                bottom: 25,
                                left: SizeQ.wight(context: context)*0.15+70,
                                right: SizeQ.wight(context: context)*0.15+90,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow:[
                                        BoxShadow(
                                          offset: Offset(0,10),
                                          color: Colors.black,
                                          spreadRadius: 1.8,
                                          blurRadius: 15,
                                        ),
                                      ]
                                  ),
                                  height: 2,))
                          ],
                        ),
                        Positioned(
                          bottom: 15,
                          left: 15,
                          child: Container(
                            margin: EdgeInsets.only(bottom:discounts?35:0),
                            decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(5)),
                            child:AddToCartWidget(Prudact: widget.Prudact,SizeIcon: 40,ColorIcon: Colors.pink),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text('${widget.Prudact['Name']}',style: const TextStyle(fontSize: 40,color:Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            discounts?
            Container(
              width: double.infinity,
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left:SizeQ.wight(context: context)*0.04,right:SizeQ.wight(context: context)*0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      discounts?
                      DiscountWidget(Prise: widget.Prudact['Prise']*1.0, Discount: widget.Prudact['Discount']*1.0, Size1: 20)
                          :
                      const Text(''),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('₪${widget.Prudact['Prise']*1.0}',style: const TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough
                        ),),
                        SizedBox(width: 15,),
                        Text('₪${widget.Prudact['Prise']*1.0-widget.Prudact['Discount']*1.0} ',style: const TextStyle(fontSize: 35,color: Colors.pink,fontWeight: FontWeight.w500),)
                      ],
                      )
                    ],
                  ),
                ),
              ),
            )
                :
            Text('₪ ${widget.Prudact['Prise']*1.0}  السعر',style: const TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Align(
                alignment: Alignment.center,
                child: Text('${widget.Prudact['PrudactsDetals']}',style: const TextStyle(fontSize: 18,color: Colors.black,),)),
          ],
        ),
      ) ,
    );
  }
}
