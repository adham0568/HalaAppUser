import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Discount.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/PrudactShow.dart';
import 'package:provider/provider.dart';

import '../../../../provider/CartProvider.dart';
import '../../../../provider/TotalPrudact.dart';
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
    double H = MediaQuery.of(context).size.height;
    final Provaider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
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
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Discaount(UidAdmin: widget.ResturntData['Uid']),));
                          },
                          child: Container(
                            padding:EdgeInsets.only(left: w/15,right: w/15),
                            margin: const EdgeInsets.only(left: 50,right: 50,bottom: 5,top: 50),
                            height: H/16,width: w/2.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(56, 95, 172, 1), Color.fromRGBO(1, 183, 168, 1),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.percent,color: Colors.white,size: H/30,),
                                Text('عروض',style: TextStyle(fontSize: H/30,color: Colors.white,fontWeight: FontWeight.bold),)
                              ],
                            ),
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
                              shrinkWrap: true,
                              children: List.generate(
                                snapshot.data!.docs.length,
                                    (index) {
                                  Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                                  return Container(
                                    margin: const EdgeInsets.only(top: 40),
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        childAspectRatio:2.2/3,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(
                                          parent: AlwaysScrollableScrollPhysics(),
                                        ),
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
                                                        gradient: const LinearGradient(begin: Alignment.bottomLeft,end:Alignment.bottomRight ,colors: [
                                                          Color.fromRGBO(56, 95, 172, 1),
                                                          Color.fromRGBO(1, 183, 168, 1)
                                                        ]),
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
          Positioned(top: H/8,left: w/10,right: w/10,
              child: Container(
                height: H/5.5,width: w*0.9,decoration:
                BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // لون الظل
                      spreadRadius: 3, // انتشار الظل
                      blurRadius: 10, // ضبابية الظل
                      offset: const Offset(0, 7), // إزاحة الظل بالنسبة للعرض والارتفاع
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
                      margin: EdgeInsets.only(left:w/10 ,right: w/10,top: w/40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 15,),
                                Text(widget.ResturntData['Username'].toUpperCase(),style: const TextStyle(
                                  color: Colors.black45,fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text(widget.ResturntData['TybeMarket'].toString().toUpperCase(),style: const TextStyle(
                                    color: Colors.black45,fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            const SizedBox(width: 15,),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(1, 183, 168, 1),
                                  Color.fromRGBO(56, 95, 172, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),),
                              height: 80,
                              width: 80,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
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
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,color:  Color(0xFFFFD700),size: 27,),
                                  const Text('4.5',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black45),),
                                  InkWell(
                                      onTap: (){},
                                      child: Container(
                                          margin: const EdgeInsets.only(left: 5),
                                          child: const Text('التقيمات',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black45),))),
                                  Container(height: 20,width: 2,color: Colors.black45,margin: const EdgeInsets.only(left: 10,right: 10),),
                                  const Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delivery_dining,color: Colors.black45,size: 27,),
                                      SizedBox(width: 5),
                                      Text('${7} ₪',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),)
                                    ],),
                                  Container(height: 20,width: 2,color: Colors.black45,margin: const EdgeInsets.only(left: 10,right: 10),),
                                  const Row(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.timelapse,color:  Colors.grey,size: 27,),
                                      Text(' ${45}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),)
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
