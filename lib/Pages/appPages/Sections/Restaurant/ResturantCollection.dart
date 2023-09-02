import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Discount.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/PrudactShow.dart';
import 'package:halaapp/Pages/appPages/Sections/popular.dart';
import 'package:halaapp/models/Rating/RatingPage.dart';
import 'package:provider/provider.dart';

import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';
import '../../../RatingPages/RatingWidget.dart';
import '../../Cart/CartPage.dart';

class ResturntCollection extends StatefulWidget {
  Map ResturntData;
  ResturntCollection({Key? key,required this.ResturntData}) : super(key: key);

  @override
  State<ResturntCollection> createState() => _ResturntCollectionState();
}

class _ResturntCollectionState extends State<ResturntCollection> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final Provaider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: h/4,
                pinned: true,
                backgroundColor: Colors.black12,
                flexibleSpace: FlexibleSpaceBar(
                   background: CachedNetworkImage(
                    imageUrl: widget.ResturntData['ImageProfile'],
                    placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        Container(
                          margin: EdgeInsets.only(top: h/10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Discaount(UidAdmin: widget.ResturntData['Uid'],which_Page: false),));
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: w/15,right: w/15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black54
                                  ),
                                  child: Center(child: Text(' % عروض',style: TextStyle(fontSize: h/30,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                              SizedBox(width: w/15,),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => popular(which: 1,Uid:widget.ResturntData['Uid'] ,)));
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: w/15,right: w/15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54
                                  ),
                                  child: Center(child: Text('الاكثر طلبا',style: TextStyle(fontSize: h/30,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),

                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('mainCollection')
                              .where('UidAdmin', isEqualTo: widget.ResturntData['Uid'])
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading");
                            }


                            return ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                1,
                                    (index) {
                                  Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                                  return Container(
                                    margin: const EdgeInsets.only(top: 40),
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        childAspectRatio:2.2/3,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(w / 60),
                                        crossAxisCount: 3,
                                        children: List.generate(
                                          snapshot.data!.docs.length,
                                              (int index) {
                                            return AnimationConfiguration.staggeredGrid(
                                              position: index,
                                              duration: const Duration(milliseconds: 500),
                                              columnCount: 3,
                                              child: ScaleAnimation(
                                                duration: const Duration(milliseconds: 900),
                                                curve: Curves.fastLinearToSlowEaseIn,
                                                scale: 1.5,
                                                child: FadeInAnimation(
                                                  child: InkWell(
                                                    splashColor: Colors.teal,
                                                    borderRadius: BorderRadius.circular(15),
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) =>
                                                              PrudactsRust(DataFromMainCollection:snapshot.data!.docs[index].data()! as Map<String, dynamic>),));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                        bottom: w / 30,
                                                        left: w / 60,
                                                        right: w / 60,
                                                      ),
                                                      decoration: BoxDecoration(
                                                      color: Colors.black45,
                                                        borderRadius: const BorderRadius.all(
                                                          Radius.circular(15),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.1),
                                                            blurRadius: 40,
                                                            spreadRadius: 10,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(top: 10),
                                                            height: 100,
                                                            width: double.infinity,
                                                            child: CachedNetworkImage(
                                                              imageUrl: snapshot.data!.docs[index]['Image'],
                                                              placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                            ),
                                                          ),
                                                          Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                                                          //  snapshot.data!.docs[index]
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
                              ).toList(),
                            );
                          },
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
          Positioned(top: h/7,left: w/13,right: w/13,
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
                            Text(widget.ResturntData['Username'].toUpperCase(),style: TextStyle(
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
                                      imageUrl: widget.ResturntData['ProfileImage'],
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
                                  RatingWidget(idMarket: widget.ResturntData['Uid']),
                                  InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RatingPage(
                                          ResturntData: widget.ResturntData,
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
                ),))
        ],
      ),
    );

  }
}
