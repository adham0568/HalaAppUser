import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Hala/Offer.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Discount.dart';
import 'package:halaapp/models/Adds/ModelApp.dart';
import 'package:provider/provider.dart';
import '../../../../models/Adds/ModelApp.dart';
import '../../../../models/CartProvider.dart';
import '../../../../models/Color.dart';
import '../../../../models/Rating/RatingPage.dart';
import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';
import '../../../RatingPages/RatingWidget.dart';
import '../../../homepage.dart';
import '../../Cart/CartPage.dart';
import '../SearchPage.dart';
import 'CollectionPage.dart';
import 'PrudactHala.dart';

class marketPage extends StatefulWidget {
  int whichPage;
  String idAdmin;
  Map<String,dynamic> DataRestaurnat;
  marketPage({required this.idAdmin,required this.DataRestaurnat,required this.whichPage,Key? key}) : super(key: key);

  @override
  State<marketPage> createState() => _marketPageState();
}

class _marketPageState extends State<marketPage> {
  List prudact=[];
  List Ads=[];
  String _idAdmin='';
  bool DataComeing=false;
  GetDataUser({required String IdAdmin}) {
    FirebaseFirestore.instance.collection('AdminData')
        .doc(IdAdmin)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> adminData = snapshot.data() as Map<String, dynamic>;
        prudact=adminData['Produacts'];
        Ads=adminData['AddImage'];
        setState(() {
          DataComeing==true;
        });
      } else {
        print("Document does not exist");
      }
    })
        .catchError((error) {
      print("Error retrieving data: $error");
    });
  }
  Map MarketData={};
  ColorModel CM=ColorModel();
  @override
  void initState() {
    widget.whichPage==0?_idAdmin=widget.idAdmin:_idAdmin=widget.DataRestaurnat['Uid'];
    GetDataUser(IdAdmin:_idAdmin);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);
    if(widget.whichPage==0){
      return DataComeing==false? Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.teal.withOpacity(0.7),
                            Colors.teal.withOpacity(0.9)
                          ]
                      )
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: w/5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(Product: prudact,Name: "منتجات",whichPage: 1,NamePrudact: '',),));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              height:h/15 ,
                              width: w*0.8,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: CM.W1),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.search_rounded,color:CM.W1,),
                                  Text('ابحث عن المنتجات هنا',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CM.W1),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: w/18,),
                        Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                splashColor: CM.T1,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Offer(product: prudact,numberOfPage:0),));
                                },
                                child: Container(width: w*0.45,
                                  height: w*0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:CM.b3,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('العروض',style: TextStyle(fontWeight: FontWeight.bold,color: CM.W1),),
                                      Icon(Icons.percent,color: CM.W1,)
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: CM.T1,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Offer(product: prudact,numberOfPage: 1,),));

                                },
                                child: Container(width: w*0.45,
                                  height: w*0.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:CM.b3,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('🔥 الأكثر رواجاً',style: TextStyle(fontWeight: FontWeight.bold,color: CM.W1),),
                                      Icon(Icons.trending_up,color: CM.W1,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              expandedHeight: h/3,
              pinned: true,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              actions: [
                CartWidget(h: w*0.1, w: w*0.1)
              ],
              title:Text('Hala Market',style: TextStyle(fontWeight: FontWeight.w500,color: CM.W1,fontSize: 20),),
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Column(
                    children: [
                      Center(
                        child:Ads.length>0 && Ads!=null ? Container(
                            child:ImageAnimation(AddList: Ads,Product: prudact,)
                        ):Container(),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Align(alignment: Alignment.topRight,
                              child: Text('تسوق حسب الصنف',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(left: 9,right: 9),
                            width: w*0.95,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('Collection').where('UidAdmin',isEqualTo: _idAdmin).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Text("Loading");
                                }
                                return SizedBox(
                                  child:AnimationLimiter(
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      childAspectRatio:w*0.6/w*1,
                                      crossAxisSpacing: 0,
                                      physics:const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(left: w / 60,right: w / 60,bottom: w / 60 ,top: w / 60 ),
                                      crossAxisCount: columnCount,
                                      children: List.generate(
                                        snapshot.data!.size,
                                            (int index) {
                                          return AnimationConfiguration.staggeredGrid(
                                            position: index,
                                            duration: const Duration(milliseconds: 500),
                                            columnCount: columnCount,
                                            child: ScaleAnimation(
                                              duration: const Duration(milliseconds: 900),
                                              curve: Curves.fastLinearToSlowEaseIn,
                                              scale: 1.5,
                                              child: FadeInAnimation(
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(12),
                                                  splashColor: Colors.teal,
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => CollectionPage(prudact:prudact,DataFromCollection: snapshot.data!.docs[index]['IdCollection'],documents: snapshot.data!.docs,)));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: w / 15, left: w / 60, right: w / 60),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black.withOpacity(0.3),
                                                            blurRadius: 5,
                                                            spreadRadius: 2,
                                                            offset: const Offset(5,2)
                                                        ),
                                                      ],
                                                    ),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.all(5),
                                                          height: 100,
                                                          width: 100,
                                                          child: CachedNetworkImage(
                                                            imageUrl: snapshot.data!.docs[index]['ImageUrl'],fit: BoxFit.fill,
                                                            placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                                            imageBuilder: (context, imageProvider) => Container(
                                                              height: 110,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                image: DecorationImage(
                                                                  image: imageProvider,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(child: Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black),))
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
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 50,),
                        ],
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      )
          :
      Container(color: Colors.white,child: Center(child: CircularProgressIndicator(color: Colors.teal,),),)
      ;
    }
    else if(widget.whichPage==1){return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /**/
              SliverAppBar(
                expandedHeight: h/3.5,
                pinned: true,
                backgroundColor: Colors.black12,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.DataRestaurnat['ImageProfile'],
                          placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Positioned(top: h/10,left: w/13,right: w/13,
                          child: Container(
                            height: h/4.8,width: w*0.9,decoration:
                          BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3), // لون الظل
                                spreadRadius: 3, // انتشار الظل
                                blurRadius: 5, // ضبابية الظل
                                offset: const Offset(0, 3), // إزاحة الظل بالنسبة للعرض والارتفاع
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,)
                            ,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left:w/15 ,right: w/30,top: w/40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.DataRestaurnat['Username'].toUpperCase(),style: TextStyle(
                                          color: Colors.black45,fontSize: w/20,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      const SizedBox(width: 15,),
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: const LinearGradient(
                                          colors: [
                                            Colors.teal,
                                            Colors.tealAccent
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),),
                                        height: h/8.8,
                                        width: h/8.8,
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(5),
                                            height: h/8.8,
                                            width: h/8.8,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white,),
                                            child: Center(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: widget.DataRestaurnat['ProfileImage'],
                                                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: w/17,right: w/30,bottom: w/30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              RatingWidget(idMarket: widget.DataRestaurnat['Uid']),
                                              InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RatingPage(
                                                      ResturntData: widget.DataRestaurnat,
                                                    ),));
                                                  },
                                                  child: Container(
                                                      margin: const EdgeInsets.only(left: 5),
                                                      child:Text('التقيمات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/25,color: Colors.black45,
                                                        decoration: TextDecoration.underline, // تفعيل الخط تحت النص
                                                        decorationColor: Colors.black26, // لون الخط
                                                        decorationThickness: 1, // سمك الخط
                                                      ),))),
                                              Container(height: 20,width: 2,color: Colors.black45,margin: const EdgeInsets.only(left: 10,right: 10),),
                                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delivery_dining,color: Colors.black45,size: w/18,),
                                                  SizedBox(width: 5),
                                                  Text('${7} ₪',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/25,color: Colors.black45),)
                                                ],),
                                              Container(height: 20,width: 2,color: Colors.black45,margin: const EdgeInsets.only(left: 10,right: 10),),
                                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.timelapse,color:  Colors.grey,size: w/18,),
                                                  Text(' ${45}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/25,color: Colors.black45),)
                                                ],),
                                            ],),

                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),)),
                    ],
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    width: 40,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 9,
                          left: 15,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 222, 207, 100),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Consumer<total>(
                                builder: (context, value, child) {
                                  return Text(
                                    value.Num1().toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black45,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 2,
                          left: 1,
                          bottom: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.cart,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Column(
                      children: [
                        Center(
                          child:Ads.length>0 && Ads!=null ? Container(
                              child:ImageAnimation(AddList: Ads,Product: prudact,)
                          ):Container(),
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Align(alignment: Alignment.topRight,
                                child: Text('تسوق حسب الصنف',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.only(left: 9,right: 9),
                              width: w*0.95,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('mainCollection').where('UidAdmin',isEqualTo: _idAdmin).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Text("Loading");
                                  }
                                  return SizedBox(
                                    child:AnimationLimiter(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        childAspectRatio:w*0.6/w*1,
                                        crossAxisSpacing: 0,
                                        physics:const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(left: w / 60,right: w / 60,bottom: w / 60 ,top: w / 60 ),
                                        crossAxisCount: columnCount,
                                        children: List.generate(
                                          snapshot.data!.size,
                                              (int index) {
                                            return AnimationConfiguration.staggeredGrid(
                                              position: index,
                                              duration: const Duration(milliseconds: 500),
                                              columnCount: columnCount,
                                              child: ScaleAnimation(
                                                duration: const Duration(milliseconds: 900),
                                                curve: Curves.fastLinearToSlowEaseIn,
                                                scale: 1.5,
                                                child: FadeInAnimation(
                                                  child: InkWell(
                                                    borderRadius: BorderRadius.circular(12),
                                                    splashColor: Colors.teal,
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => PrudactPageForHalaMart(whichPage: 1,IdMainCollection:snapshot.data!.docs[index]['IdPrudactMainCollection'] ,documents: snapshot.data!.docs,productData:prudact,))
                                                      );
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: w / 15, left: w / 60, right: w / 60),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black.withOpacity(0.3),
                                                              blurRadius: 5,
                                                              spreadRadius: 2,
                                                              offset: const Offset(5,2)
                                                          ),
                                                        ],
                                                      ),
                                                      child:Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.all(5),
                                                            height: 100,
                                                            width: 100,
                                                            child: CachedNetworkImage(
                                                              imageUrl: snapshot.data!.docs[index]['Image'],fit: BoxFit.fill,
                                                              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                              imageBuilder: (context, imageProvider) => Container(
                                                                height: 110,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  image: DecorationImage(
                                                                    image: imageProvider,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Center(child: Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black),))
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
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 50,),
                          ],
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );}
    else{return Container();}
  }
}
