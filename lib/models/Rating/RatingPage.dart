import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Rating/FireBaseStatment.dart';
import 'package:intl/intl.dart';

import '../../Pages/RatingPages/RatingWidget.dart';

class RatingPage extends StatefulWidget {
  Map ResturntData;
  RatingPage({Key? key,required this.ResturntData}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final DataBaseRate _dataBaseRate = DataBaseRate();
  List Rate = [];
  bool showRate=false;
  Future<void> getData() async {
    await _dataBaseRate.GetDataRate(IdMarket: widget.ResturntData['Uid']);
    setState(() {
      Rate = _dataBaseRate.Rating;
      showRate=true;
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: h/5,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent
                      ]
                    )
                  ),
                  child: Center(
                    child: SafeArea(
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: widget.ResturntData['ProfileImage'],
                        placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),

              )
          ),
                  SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                          (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.teal,
                                            Colors.tealAccent,
                                          ]
                                        )
                                      ),
                                      child: Center(child: Text(widget.ResturntData['Username'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: w/10,color: Colors.white),))),
                                  showRate? SizedBox(
                                    height: h*0.7,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: Rate.length,
                                      itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.only(left: w/20,right: w/20,bottom: w/40,top: w/40),
                                        margin: EdgeInsets.only(left: w/20,right: w/20,bottom: w/100),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: Colors.black26,width: 1)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.star, color: Color(0xFFFFD700), size: w/18),
                                                    Text(
                                                      Rate[index]['RateStars'].toString(),
                                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: w/24),
                                                    )
                                                  ],
                                                ),
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child:Text(DateFormat.yMd().add_jm().format(Rate[index]['Date'].toDate()).toString(),
                                                      style: TextStyle(fontSize: w/30,color: Colors.black,fontWeight: FontWeight.w300),),
                                                ),
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(Rate[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold),)),
                                              ],
                                            ),
                                            Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(Rate[index]['Comment'],style: TextStyle(fontWeight: FontWeight.w400),)),
                                          ],
                                        ),);
                                    },),
                                  )
                                      :
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                ],
                              ),
                            );
                          })
                  )
        ],
      ),
    );
  }
}
/*Stack(
                  children: [
                    Positioned(
                      top: h/7,
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

                                ),
                              ],
                            )
                          ],
                        ),),
                    ),
                  ],
                ),*/