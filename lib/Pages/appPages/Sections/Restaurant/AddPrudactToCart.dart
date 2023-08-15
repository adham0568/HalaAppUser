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
List FinalPrise1=[];
List Num=[];
bool ShowOpitions=true;
int Count=0;
int additionPrise=0;
class _AddToCartResturant1State extends State<AddToCartResturant1> {

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
  //[[0,0],[2,0,0]]
CalculatorPrise({required List Pri}){
  int Prise1=0;
    for(int i=0;i<Pri.length;i++){
      for(int a=0;a<Pri[i].length;a++)
      {int Prise2=Pri[i][a];
        Prise1+=Prise2;}
    }
  additionPrise=Prise1;
    print(Prise1);
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
    createListPrice();
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Provaider = Provider.of<CartProvider>(context);
    final Provaider1 = Provider.of<total>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
            color:Colors.black26.withOpacity(0.04),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 20),
                        height: h/3.7,
                        child: CachedNetworkImage(
                          imageUrl: widget.Prudact1['ImageUrl'],
                          placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                            height: h/3.7,
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
                      widget.Prudact1['Discount']>0?Positioned(
                        left: 5,
                        top: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.gift,color: Colors.black,size: 35,),
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
                  Text(widget.Prudact1['Name'],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(widget.Prudact1['PrudactsDetals'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black),
                        textAlign: TextAlign.right,  // Align text to the right
                        textDirection: TextDirection.rtl, // Start from the right
                      ),
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
                                                test = widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice'];
                                                widget.Prudact1['Opitions'][index]['subOptions'].forEach((item) {
                                                  item['add'] = false;
                                                  int itemIndex = widget.Prudact1['Opitions'][index]['subOptions'].indexOf(item);
                                                  if (itemIndex >= 0 && itemIndex < FinalPrise1[index].length) {
                                                    FinalPrise1[index][itemIndex] = 0;
                                                  }
                                                });
                                                test = widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice'];
                                                widget.Prudact1['Opitions'][index]['subOptions'][index1]['add'] = true;
                                                FinalPrise1[index][index1] = widget.Prudact1['Opitions'][index]['subOptions'][index1]['optionPrice'];
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
                        SizedBox(height:h*0.16 ,),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () async {
                            if(Provaider.Products.isNotEmpty){
                              if(Provaider.Products.first.IdMarket==myItems!.IdMarket){
                                myItems!.Prise=myItems!.Prise+additionPrise;
                                Provaider.addPrudact(item: myItems!);

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
                                              myItems!.Prise=myItems!.Prise+additionPrise;
                                              Provaider.addPrudact(item: myItems!);
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
                              Provaider1.addNum();
                              _width = 140;
                              _height = 30;
                              myItems!.Prise=myItems!.Prise+additionPrise;
                              setState(() {
                                Provaider.AddToCart(item: myItems!);
                              });

                              Provaider.GetNumberByProducts(myItems!) + 1;
                              Provaider.GetNumberByProducts(myItems!) > 0 ? add = true : add = false;
                            }
                            Provaider.price=FinalPrise+Provaider.price;
                            Navigator.pop(context);
                            showSnackBar(context: context, text: 'تم اضافة المنتج الى السلة', color1: Colors.green);
                          },
                          child: Container(
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.teal,
                                Colors.tealAccent
                              ]
                            )
                            ),
                            width: w*0.6,
                            height:h*0.06,
                            child: Center(child: Text('إضافة',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),
                        ElevatedButton(onPressed:() {print(Provaider.price);}, child: Text('prise'))
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
/*  CreatListPrise({required List<int> a}){
    int Opitions=0;
    int mainOptions=widget.Prudact1['Opitions'].length;
    for(int i=0;i<mainOptions;i++)
    {int Count=widget.Prudact1['Opitions'][i]['subOptions'].length;
      Opitions+=Count;
    }
    a = List.generate(Opitions, (index) => index == 0 ? widget.Prudact1['Prise']:0);
    FinalPrise1=a;
}*/