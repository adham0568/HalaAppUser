import 'dart:async';

import 'package:flutter/material.dart';
import 'package:halaapp/models/Item.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';

import '../provider/CartProvider.dart';
class AddToCartWidget extends StatefulWidget {
  final double SizeIcon;
  final Color ColorIcon;
  final Map Prudact; //استلام تفاصيل المنتج الذي يتم اضافته من صفحة prudactDesgine
  AddToCartWidget({required this.ColorIcon,required this.SizeIcon,Key? key, required this.Prudact}) : super(key: key);

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}
bool add = false;

class _AddToCartWidgetState extends State<AddToCartWidget> {
  @override
  void initState() {
    myItems = Item(
        IdMarket: widget.Prudact['IdMarket'],
        Discount: widget.Prudact['Discount'],
        Name: widget.Prudact['Name'],
        IdCollection: widget.Prudact['IdCollection'],
        IdMainCollection: widget.Prudact['IdMainCollection'],
        IdPrudact: widget.Prudact['IdPrudact'],
        ImageUrl: widget.Prudact['ImageUrl'],
        PrudactsDetals: widget.Prudact['PrudactsDetals'],
        Prise: widget.Prudact['Prise']-widget.Prudact['Discount'],
        TybePrudact:widget.Prudact['TybePrudact'] ,
        Opitions: widget.Prudact['Opitions'],
    );
    // TODO: implement initState
    super.initState();
  }

  Item? myItems;
  double _width = 50;
  double _height = 20;

  @override
  Widget build(BuildContext context) {
    final Provaider = Provider.of<CartProvider>(context);
    final Provaider1 = Provider.of<total>(context);

    Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
    return InkWell(
      onTap: () {
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

      },
      child: add
          ? Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white70),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Provaider.addPrudact(item: myItems!);
                          print(Provaider.IdPrudacts);
                          setState(() {
                            Provaider.AddToCart(item:myItems!);
                            Provaider1.addNum();
                            Timer(const Duration(seconds: 3), () { setState(() {
                              add=true;
                            });});
                          });
                        },
                        icon:const Icon(
                          Icons.add,
                          color: Colors.teal,
                        )),
                    Text(
                      Provaider.GetNumberByProducts(myItems!).toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          print(Provaider.IdPrudacts);
                          Provaider.removePrudact(item: myItems!);
                          Provaider1.removeNum();
                          setState(() {
                            Provaider.RemoveToCart(myItems!,myItems!.IdPrudact);
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.teal,
                        )),
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Provaider.GetNumberByProducts(myItems!) >= 1
                      ? Colors.tealAccent
                      : Colors.white70,
                  borderRadius: BorderRadius.circular(5)),
              height: widget.SizeIcon+5,
              width:  widget.SizeIcon+5,
              child:Center(
                child: Icon(
                  Icons.add,
                  color: widget.ColorIcon,
                  size: widget.SizeIcon,
                ),
              )),
    );
  }
}
