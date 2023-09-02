import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/Hala/PrudactHala.dart';


class CollectionPage extends StatefulWidget {
  String DataFromCollection;
  List<DocumentSnapshot> documents;

  CollectionPage({Key? key,required this.DataFromCollection,required this.documents}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String MainCollectionId='';
  @override
  void initState() {
    MainCollectionId=widget.DataFromCollection;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
                        MainCollectionId=widget.documents[index]['IdCollection'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border:MainCollectionId==widget.documents[index]['IdCollection']?Border.all(width: 2,color: Colors.green):Border(),
                          color: MainCollectionId==widget.documents[index]['IdCollection']?Colors.black:Colors.black26,borderRadius: BorderRadius.circular(15)),
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
                                  imageUrl: widget.documents[index]['ImageUrl'],
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('mainCollection')
                          .where('IdCollection', isEqualTo:MainCollectionId)
                          .get(),

                      builder:
                          (BuildContext context, AsyncSnapshot snapshot) {

                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            margin: EdgeInsets.only(top: w/10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:h*0.9,
                                  child: GridView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,childAspectRatio: 35/40,crossAxisSpacing: 5),
                                      itemBuilder: (context, index) {
                                       return InkWell(
                                         splashColor: Colors.teal,
                                         borderRadius: BorderRadius.circular(15),
                                         onTap: (){
                                           DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                                           Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>PrudactPageForHalaMart(DataFromCollection:data,documents: snapshot.data!.docs,)));
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

                                                Container(child: Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),)),
                                              ],
                                            ),
                                         ),
                                       );
                                      },),
                                ),
                              ],
                            ),
                          );
                        }

                        return const Text("loading");
                      },
                    ),




                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
