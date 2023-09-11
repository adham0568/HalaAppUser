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
  int whichPage;
  String IdMainCollection;
  List productData;
  List<DocumentSnapshot> documents;

  PrudactPageForHalaMart({required this.productData,super.key,required this.whichPage, required this.IdMainCollection,required this.documents});
  @override
  State<PrudactPageForHalaMart> createState() => _PrudactPageForHalaMartState();
}
String? numOfPrudacts;
class _PrudactPageForHalaMartState extends State<PrudactPageForHalaMart> with SingleTickerProviderStateMixin {
  String MainCollectionId='';
  @override
  void initState() {
    if(widget.whichPage==0){MainCollectionId=widget.IdMainCollection;}
    if(widget.whichPage==1){MainCollectionId=widget.IdMainCollection;}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);
    if(widget.whichPage==0){
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
              GridView2(productData: widget.productData,idMainCollection:MainCollectionId,),
            ],
          ),
        ),
      );
    }
    else if(widget.whichPage==1){
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
                            border:MainCollectionId==widget.documents[index]['IdPrudactMainCollection']?Border.all(width: 1,color: Colors.red):Border(),
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
              GridView2(idMainCollection:MainCollectionId,productData: widget.productData),
            ],
          ),
        ),
      );
    }
    else{return Container();}
  }
}




