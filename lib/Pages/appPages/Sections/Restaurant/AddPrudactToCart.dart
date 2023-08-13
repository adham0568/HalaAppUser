import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/snack.dart';
import 'package:provider/provider.dart';

import '../../../../models/Item.dart';
import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';

class AddToCartResturant1 extends StatefulWidget {
  Map Prudact1;

  AddToCartResturant1({Key? key,required this.Prudact1}) : super(key: key);

  @override
  State<AddToCartResturant1> createState() => _AddToCartResturant1State();
}
bool ShowOpitions=true;
class _AddToCartResturant1State extends State<AddToCartResturant1> {

  @override
  Item? myItems;
  int test=0;
  bool add = false;
  double _width = 50;
  double _height = 20;
  int FinalPrise=0;
  @override
  void initState() {
    setState(() {
      myItems = Item(
        IdMarket: widget.Prudact1['IdMarket'],
        Discount: widget.Prudact1['Discount'],
        Name: widget.Prudact1['Name'],
        IdCollection: widget.Prudact1['IdCollection'],
        IdMainCollection: widget.Prudact1['IdMainCollection'],
        IdPrudact: widget.Prudact1['IdPrudact'],
        ImageUrl: widget.Prudact1['ImageUrl'],
        PrudactsDetals: widget.Prudact1['PrudactsDetals'],
        Prise: widget.Prudact1['Prise']-widget.Prudact1['Discount'],
        TybePrudact:widget.Prudact1['TybePrudact'] ,
        Opitions: widget.Prudact1['Opitions'],
      );
    });
        super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final Provaider = Provider.of<CartProvider>(context);
    final Provaider1 = Provider.of<total>(context);

    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.Prudact1['ImageUrl'],
                      placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    widget.Prudact1['Discount']>0?Positioned(
                      left: 5,
                      top: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.gift,color: Colors.teal,size: 35,),
                          Row(
                            children: [
                              Text('${widget.Prudact1['Discount']}₪',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)),
                              const Text('خصم بقيمة ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal)),
                            ],
                          )
                        ],
                      ),
                    ):const Text('')
                  ],
                ),
                Text(widget.Prudact1['Name'],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.teal),),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(widget.Prudact1['PrudactsDetals'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.teal),
                    textAlign: TextAlign.right,  // Align text to the right
                    textDirection: TextDirection.rtl, // Start from the right
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:widget.Prudact1['Opitions'].length ,
                        itemBuilder: (context, index) =>
                            Container(
                              margin: const EdgeInsets.only(top: 5,bottom: 5,right: 20,left: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.Prudact1['Opitions'][index]['mainOption'],
                                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black45),),
                                   ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.Prudact1['Opitions'][index]['subOptions'].length
                                    ,itemBuilder: (context, index1) => Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice']>0?
                                            Text('${widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice']} ₪',
                                              style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),)
                                                :
                                            const Text(''),
                                            const SizedBox(width: 30,),
                                            Text(widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionName'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  test= widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice'];
                                                  // تحديث قيمة add لكل عنصر ضمن القائمة إلى false
                                                  widget.Prudact1['Opitions'][index]['subOptions'].forEach((item) {
                                                    item['add'] = false;
                                                    FinalPrise=0;
                                                  });
                                                  test= widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice'];
                                                  // تحديث قيمة add للعنصر المحدد إلى true
                                                  widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] = true;
                                                  FinalPrise += test;
                                                });
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    color: widget.Prudact1['Opitions'][index]['subOptions'][index1]['add']?Colors.green:Colors.white,
                                                    shape: BoxShape.circle,border: Border.all(color: Colors.black45,width: 2.5)),
                                              ),
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ) ,),
                                ],
                              ),
                            )
                        ,),
                      ElevatedButton(onPressed: () async {
                        if(Provaider.Products.isNotEmpty){
                          if(Provaider.Products.first.IdMarket==myItems!.IdMarket){
                            Provaider.addPrudact(item: myItems!);
                            print(Provaider.IdPrudacts);
                            Provaider1.addNum();
                            _width = 140;
                            _height = 30;
                            setState(() {
                              Provaider.AddToCart(item: myItems!);
                            });
                            Provaider.GetNumberByProducts(myItems!) + 1;
                            Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                          }
                          else if(Provaider.Products.first.IdMarket!=myItems!.IdMarket){
                            showDialog(context: context, builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              content: Container(
                                height: 160,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('بدء سلة جديدة؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
                                    const Text('عند بدء طلب من متجر جديد سيتم ازالة المنتجات من المتاجر الاخرى',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15,color: Colors.black54), textDirection: TextDirection.rtl,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(onPressed: (){
                                          Provaider.xid1=myItems!.IdMarket;
                                          Provaider.addPrudact(item: myItems!);
                                          print(Provaider.xid1);
                                          Provaider1.addNum();
                                          _width = 140;
                                          _height = 30;
                                          setState(() {
                                            Provaider.AddToCart(item: myItems!);
                                          });
                                          Provaider.GetNumberByProducts(myItems!) + 1;
                                          Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                                          Provaider1.Num=1;
                                          Navigator.pop(context);
                                        },
                                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal),overlayColor: MaterialStateProperty.all(Colors.red)), child: const Text('تأكيد البدء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                        ElevatedButton(onPressed: (){Navigator.pop(context);},
                                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),overlayColor: MaterialStateProperty.all(Colors.green)), child: const Text('الغاء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),);
                          }
                        }
                        else{
                          Provaider.addPrudact(item: myItems!);
                          Provaider.xid1=myItems!.IdMarket;
                          print(Provaider.xid1);
                          Provaider1.addNum();
                          _width = 140;
                          _height = 30;
                          setState(() {
                            Provaider.AddToCart(item: myItems!);
                          });

                          Provaider.GetNumberByProducts(myItems!) + 1;
                          Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                        }
                        Provaider.price=FinalPrise+Provaider.price;
                       print(Provaider.price);
                        // Navigator.pop(context);
                        showSnackBar(context: context, text: 'تم اضافة المنتج الى السلة', color1: Colors.green);
                        }, child: const Text('add')
                      ),
                      ElevatedButton(onPressed: (){print(Provaider.price);}, child: const Text('sss'))
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
