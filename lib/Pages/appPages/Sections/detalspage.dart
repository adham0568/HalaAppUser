import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    widget.Prudact['Discount']>0?discounts=true:discounts=false;
    // TODO: implement initState
    super.initState();
  }
  @override

  SizeFix SizeQ=SizeFix();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50,bottom: 15),
                height:342 ,
                width:408,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.teal,width: 3)),
                child:Center(
                  child: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          height: SizeQ.Hight(context: context)*0.4,
                          imageUrl: widget.Prudact['ImageUrl'],
                          placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      discounts?
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black38),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.gift,size: 25,color: Colors.teal),
                              Text('خصم',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal),),
                            ],
                          ),
                        ),
                      ):const Text(''),
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
            Text('${widget.Prudact['Name']}',style: const TextStyle(fontSize: 40,color: Colors.teal,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Align(
                alignment: Alignment.center,
                child: Text('${widget.Prudact['PrudactsDetals']}',style: const TextStyle(fontSize: 18,color: Colors.teal,),)),
            const SizedBox(height: 20,),
            discounts?
            Container(
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('₪${widget.Prudact['Prise']}',style: const TextStyle(fontSize: 25,color: Colors.grey,fontWeight: FontWeight.w300,
                      decoration: TextDecoration.lineThrough
                    ),),
                    SizedBox(width: 15,),
                    Text('₪${widget.Prudact['Prise']-widget.Prudact['Discount']} ',style: const TextStyle(fontSize: 35,color: Colors.pink,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            )
                :
            Text('₪ ${widget.Prudact['Prise']}  السعر',style: const TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold),),
          ],
        ),
      ) ,
    );
  }
}
