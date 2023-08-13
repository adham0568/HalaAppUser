/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Pages/appPages/Sections/detalspage.dart';
import 'add.dart';

class PrudactWidget extends StatefulWidget {
  Map DataPrudact;
  PrudactWidget({Key? key,required this.DataPrudact}) : super(key: key);

  @override
  State<PrudactWidget> createState() => _PrudactWidgetState();
}
bool add=false;

class _PrudactWidgetState extends State<PrudactWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Prudacts')
          .where('IdMainCollection', isEqualTo:widget.DataPrudact['IdPrudactMainCollection'])
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              SizedBox(height: 10,),
              SizedBox(
                height: snapshot.data!.docs.length.isOdd? snapshot.data!.docs.length* 160.0:snapshot.data!.docs.length*150.0/1.2,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 15,mainAxisSpacing: 10,mainAxisExtent: 220),
                  itemBuilder: (context, index) =>
                      InkWell(
                        borderRadius:BorderRadius.circular(15),
                        onTap: (){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detales(
                                      idprudact: snapshot.data!.docs[index]['IdPrudact'],
                                      Img: snapshot.data!.docs[index]['ImageUrl'],
                                      price: snapshot.data!.docs[index]['Prise'],
                                      detales: snapshot.data!.docs[index]['PrudactsDetals'],
                                      name: snapshot.data!.docs[index]['Name'],
                                      Prudact:snapshot.data!.docs[index].data()!.map((key, value) => MapEntry(key, value)),
                                  )));
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.teal,width: 3)),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data!.docs[index]['ImageUrl'],
                                    placeholder: (context, url) => CircularProgressIndicator(color: Colors.red),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 125,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    left: 2,
                                    child:AddToCartWidget(Prudact:snapshot.data.docs[index].data() as Map<String, dynamic>,)
                                  )
                                ],
                              ),
                              Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(height: 5,),
                              Text(snapshot.data!.docs[index]['Prise'].toString()+' ₪',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                            ],
                          ),
                        ),
                      ),
                ),
              )
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}*/

