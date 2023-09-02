import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/PrudactDesgineAnimation.dart';
import 'package:halaapp/provider/CartProvider.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';

import '../../../../models/CartProvider.dart';
import '../../../../models/CloseWidget.dart';
import '../../Cart/CartPage.dart';

class PrudactPageForHalaMart extends StatefulWidget {
  Map DataFromCollection;
  List<DocumentSnapshot> documents;

  PrudactPageForHalaMart({super.key, required this.DataFromCollection,required this.documents});
  @override
  State<PrudactPageForHalaMart> createState() => _PrudactPageForHalaMartState();
}
String? numOfPrudacts;
class _PrudactPageForHalaMartState extends State<PrudactPageForHalaMart> with SingleTickerProviderStateMixin {
  String MainCollectionId='';
  @override
  void initState() {
    MainCollectionId=widget.DataFromCollection['IdPrudactMainCollection'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              SizedBox(
                height: h/20,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: widget.documents.length,
                  controller: ScrollController(
                    initialScrollOffset: 0 *  w/3,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      setState(() {
                        MainCollectionId=widget.documents[index]['IdPrudactMainCollection'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:MainCollectionId==widget.documents[index]['IdPrudactMainCollection']?Border.all(width: 2,color: Colors.green):Border(),
                          color: MainCollectionId==widget.documents[index]['IdPrudactMainCollection']?Colors.black:Colors.black26,borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.all(2),
                      height: 10,width: w/3,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: w/40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.documents[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                height: w/13,
                                width: w/13,
                                child: CachedNetworkImage(
                                  imageUrl: widget.documents[index]['Image'],
                                  placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ) ,),
              ),
            ],
          ),
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
        body: TabBarView(
          children: [
            GridView2(Prudact: MainCollectionId),
          ],
        ),
      ),
    );
  }
}


/*  SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                  imageUrl: widget.DataFromCollection['Image'],
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

          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
           if(index.isOdd){return}
           else{return}
          },childCount:2 )),*/





