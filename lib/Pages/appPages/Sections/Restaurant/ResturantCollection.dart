import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/Discount.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/PrudactShow.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
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
  List Product=[];
  GetDataUser() {
    FirebaseFirestore.instance.collection('AdminData')
        .doc(widget.ResturntData['Uid'])
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> adminData = snapshot.data() as Map<String, dynamic>;
        Product=adminData['Produacts'];
      } else {
        print("Document does not exist");
      }
    })
        .catchError((error) {
      print("Error retrieving data: $error");
    });
  }
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
                                  padding:EdgeInsets.only(left: w/20,right: w/20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black54
                                  ),
                                  child: Center(child: Text(' % عروض',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                              SizedBox(width: w/15,),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => popular(which: 1,Uid:widget.ResturntData['Uid'] ,)));
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: w/20,right: w/20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54
                                  ),
                                  child: Center(child: Text('الاكثر طلبا',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ),
                              ),
                              SizedBox(width:w/15),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(whichPage:1,Name: 'منتجات',NamePrudact: '',Product: Product,)));
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: w/20,right: w/20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black54
                                  ),
                                  child: Center(child: Text('بحث',style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),)),
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
        ],
      ),
    );

  }
}
