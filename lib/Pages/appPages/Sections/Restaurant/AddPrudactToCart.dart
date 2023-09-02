import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/CartProvider.dart';
import 'package:halaapp/models/snack.dart';
import 'package:provider/provider.dart';

import '../../../../models/CloseWidget.dart';
import '../../../../models/DiscountDesgin.dart';
import '../../../../models/Item.dart';
import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';
class AddToCartResturant1 extends StatefulWidget {
  Map Prudact1;
  AddToCartResturant1({Key? key,required this.Prudact1}) : super(key: key);
  @override
  State<AddToCartResturant1> createState() => _AddToCartResturant1State();
}
bool discounts=false;
List FinalPrise1=[];
List Number=[];
bool ShowOpitions=true;
int Count=0;
int additionPrise=0;
int PriseShow=0;
class _AddToCartResturant1State extends State<AddToCartResturant1> {
 bool AllowAdd(){
   bool Allow=false;
   Number.contains(null)?Allow=false:Allow=true;
   return Allow;
  }

  void ListOpitionNumber(){
    int mainOptions = widget.Prudact1['Opitions'].length;
    for(int i=0;i<mainOptions;i++){
      Number= List.generate(mainOptions, (index) => null);
    }
  }

  void createListPrice() {
    int mainOptions = widget.Prudact1['Opitions'].length;
    List<List<int>> num = [];

    for (int i = 0; i < mainOptions; i++) {
      int subOptionsLength = widget.Prudact1['Opitions'][i]['subOptions'].length;
      List<int> subList = List.generate(subOptionsLength, (index) => 0);
      num.add(subList);
    }

    FinalPrise1 = num;
  }
CalculatorPrise({required List Pri}){
  int Prise1=0;
    for(int i=0;i<Pri.length;i++){
      for(int a=0;a<Pri[i].length;a++)
      {int Prise2=Pri[i][a];
        Prise1+=Prise2;}
    }
  additionPrise=Prise1;
  PriseShow=Prise1;
}
ResetValue(){
  ListOpitionNumber();
  createListPrice();
  setState(() {
    myItems = Item(
      Count_requests:widget.Prudact1['Count_requests'] ,
      Count_Quantity:widget.Prudact1['Count_Quantity'] ,
      IdMarket: widget.Prudact1['IdMarket'],
      Discount: widget.Prudact1['Discount'],
      Name: widget.Prudact1['Name'],
      //IdCollection: widget.Prudact1['IdCollection'],
      IdMainCollection: widget.Prudact1['IdMainCollection'],
      IdPrudact: widget.Prudact1['IdPrudact'],
      ImageUrl: widget.Prudact1['ImageUrl'],
      PrudactsDetals: widget.Prudact1['PrudactsDetals'],
      Prise: widget.Prudact1['Prise']-widget.Prudact1['Discount'],
      TybePrudact:widget.Prudact1['TybePrudact'] ,
      Opitions: widget.Prudact1['Opitions'],
      OpitionSelected: Number,
    );
  });
  myItems!.Discount>0?discounts=true:discounts=false;

}
  @override
  Item? myItems;
  int test=0;
  bool add = false;
  double _width = 50;
  double _height = 20;
  int FinalPrise=0;
  @override
  void initState() {
    AllowAdd();
    ResetValue();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Provaider = Provider.of<CartProvider>(context);
    final Provaider1 = Provider.of<total>(context);

    return Scaffold(
      body: SafeArea(
        child:CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl:  widget.Prudact1['ImageUrl'],
                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Center(child: CloseWidget(w: w,icon: false)),
              ),
              actions: [
                CartWidget(h: w*0.1, w: w*0.1),
              ],
            ),
            SliverFillViewport(
                delegate: SliverChildBuilderDelegate(
                childCount: 1,(context, index) {
              return Column(
                children: [
                  discounts?
                  Container(width: _width*2,child: DiscountWidget(Prise: myItems!.Prise, Discount:myItems!.Discount, Size1: 15),):const Text(''),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(widget.Prudact1['Name'],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black87),)),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(widget.Prudact1['PrudactsDetals'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black87),
                            textAlign: TextAlign.right,  // Align text to the right
                            textDirection: TextDirection.rtl, // Start from the right
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: h/25),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:widget.Prudact1['Opitions'].length ,
                          itemBuilder: (context, index) =>
                              Container(
                                color: Colors.white.withOpacity(0.8),
                                margin: EdgeInsets.only(bottom: 5,top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: _width/7),
                                      child: Text(widget.Prudact1['Opitions'][index]['mainOption'],
                                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
                                    ),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.Prudact1['Opitions'][index]['subOptions'].length
                                      ,itemBuilder: (context, index1) => Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.teal,
                                            onTap: () {
                                              setState(() {
                                                myItems!.Opitions[index]['subOptions'].forEach((item) {
                                                  item['add'] = false;
                                                  int itemIndex =  myItems!.Opitions[index]['subOptions'].indexOf(item);
                                                  if (itemIndex >= 0 && itemIndex < FinalPrise1[index].length) {
                                                    FinalPrise1[index][itemIndex] = 0;
                                                  }
                                                });

                                                myItems!.Opitions[index]['subOptions'][index1]['add'] = true;
                                                FinalPrise1[index][index1] =  myItems!.Opitions[index]['subOptions'][index1]['optionPrice'];
                                                Number[index]=index1;
                                                AllowAdd();
                                              });
                                              CalculatorPrise(Pri: FinalPrise1);
                                            },

                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: _width/7),
                                              margin: EdgeInsets.only(bottom: 2),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      AnimatedContainer(
                                                        duration: Duration(milliseconds: 300), // مدة الانتقال بالمللي ثانية
                                                        margin: EdgeInsets.only(left: _width / 7),
                                                        height: _width / 2,
                                                        width: _width / 2,
                                                        decoration: BoxDecoration(
                                                          color: widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] ? Colors.teal : Colors.white,
                                                          shape: BoxShape.circle,
                                                          border:widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] ?
                                                          Border.all(color: Colors.white, width: 0)
                                                              :
                                                          Border.all(color: Colors.black26, width: 1.1)
                                                          ,
                                                        ),
                                                        child: Center(
                                                            child: AnimatedContainer(
                                                              duration: Duration(milliseconds: 100), // مدة الانتقال بالمللي ثانية
                                                              padding: widget.Prudact1['Opitions'][index]['subOptions'][index1]['add']
                                                                  ? EdgeInsets.only(left: 0)
                                                                  : EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                                                              child: AnimatedOpacity(
                                                                opacity: widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] ? 1.0 : 0.0,
                                                                duration: Duration(milliseconds: 100), // مدة الانتقال بالمللي ثانية
                                                                child: AnimatedContainer(
                                                                  duration: Duration(milliseconds: 100), // مدة التحجيم بالمللي ثانية
                                                                  transform: Matrix4.identity()
                                                                    ..scale(widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] ? 1.0 : 0.0),
                                                                  child: Icon(Icons.check, color: Colors.white, size: _width / 2.2),
                                                                ),
                                                              ),
                                                            )

                                                        ),
                                                      ),
                                                      SizedBox(width: _width/7,),
                                                      widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice']>0?
                                                      Text('₪${widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice']} +',
                                                        style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w300,color: Colors.black54),)
                                                          :
                                                      const Text(''),
                                                    ],
                                                  ),
                                                  Text(widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionName'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ) ,),
                                  ],
                                ),
                              )
                          ,),

                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () async {
                      if(AllowAdd()){
                        if(Provaider.Products.isNotEmpty){
                          if(Provaider.Products.first.IdMarket==myItems!.IdMarket){
                            myItems!.Prise=myItems!.Prise+additionPrise;
                            Provaider.addPrudact(item: myItems!);

                            Provaider1.addNum();
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
                                          Provaider.Products.clear();
                                          Provaider.listitem().clear();
                                          Provaider.xid1=myItems!.IdMarket;
                                          myItems!.Prise=myItems!.Prise+additionPrise;
                                          Provaider.addPrudact(item: myItems!);
                                          Provaider1.addNum();
                                          setState(() {
                                            Provaider.AddToCart(item: myItems!);
                                          });
                                          Provaider.GetNumberByProducts(myItems!) + 1;
                                          Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                                          Provaider1.Num=1;
                                          Navigator.pop(context);
                                        },
                                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal),
                                                overlayColor: MaterialStateProperty.all(Colors.red)),
                                            child: const Text('تأكيد البدء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                        ElevatedButton(onPressed: (){Navigator.pop(context);},
                                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
                                                overlayColor: MaterialStateProperty.all(Colors.green)),
                                            child: const Text('الغاء',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),)),
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
                          Provaider1.addNum();
                          myItems!.Prise=myItems!.Prise+additionPrise;
                          setState(() {
                            Provaider.AddToCart(item: myItems!);
                          });

                          Provaider.GetNumberByProducts(myItems!) + 1;
                          Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                        }
                        showSnackBar(context: context, text: 'تم اضافة المنتج الى السلة', color1: Colors.green);
                        setState(() {
                          ResetValue();
                        });
                      }
                      else{showSnackBar(context: context, text: 'الرجاء تحديد اختيارات', color1: Colors.pinkAccent);}
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors:AllowAdd()?[
                              Colors.teal,
                              Colors.tealAccent]
                                :
                            [Colors.black,
                              Colors.black],
                          )
                      ),
                      width: w*0.6,
                      height:h*0.06,
                      child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: w/7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${PriseShow+widget.Prudact1['Prise']}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                                Text('إضافة',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                              ],
                            ),
                          )),
                    ),
                  )

                ],
              );
            })),
          ],
        )
      ),
    );
  }
}
