import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/Hala/PrudactHala.dart';


class CollectionPage extends StatefulWidget {
  Map DataFromCollection;
  CollectionPage({Key? key,required this.DataFromCollection}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.DataFromCollection['Name'],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.teal),),

        FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Collection')
              .doc(widget.DataFromCollection['IdCollection']).collection('mainCollection')
              .where('IdCollection', isEqualTo:widget.DataFromCollection['IdCollection'])
              .get(),

          builder:
              (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  SizedBox(
                    height: snapshot.data!.docs.length*150.0,
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,childAspectRatio: 4/4,crossAxisSpacing: 5),
                        itemBuilder: (context, index) {
                         return InkWell(
                           splashColor: Colors.teal,
                           borderRadius: BorderRadius.circular(15),
                           onTap: (){
                             DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                             Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>PrudactPageForHalaMart(DataFromCollection:data)));
                           },
                           child: Container(
                             margin: const EdgeInsets.all(5),
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                             gradient: const LinearGradient(begin: Alignment.bottomLeft,end:Alignment.bottomRight ,colors: [
                               Color.fromRGBO(56, 95, 172, 1),
                               Color.fromRGBO(1, 183, 168, 1)
                             ])
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snapshot.data!.docs[index]['Image'],
                                    placeholder: (context, url) => const CircularProgressIndicator(color: Colors.green),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 140,
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

                                  Container(child: Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                                ],
                              ),
                           ),
                         );
                        },),
                  ),
                ],
              );
            }

            return const Text("loading");
          },
        ),




          ],
        ),
      ),
    );
  }
}
