import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/ResturantCollection.dart';
import 'package:provider/provider.dart';
import '../../../../provider/DataUser.dart';

class MPB extends StatefulWidget {
  int Tybe;
  MPB({Key? key,required this.Tybe}) : super(key: key);

  @override
  State<MPB> createState() => _MPBState();
}
String TextShow='';
bool SelectSection=false;
int? Section;
bool _favorite=false;
List<String> City = [
  "الخليل",
  "نابلس",
  "طولكرم",
  "يطا",
  "جنين",
  "البيرة",
  "دورا",
  "رام الله",
  "الظاهرية",
  "قلقيلية",
  "بيت لحم",
  "طوباس",
  "سلفيت",
  "بيت جالا",
  'بيت ساحور'
];

class _MPBState extends State<MPB> {
@override
  void initState() {
  if(widget.Tybe==10){TextShow='مخبوزات';}
  else if(widget.Tybe==11){TextShow='ملحمة';}
  else if(widget.Tybe==12){TextShow='صيدلية';}
  else{TextShow='';}
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    double w = MediaQuery.of(context).size.width;
    double hight= MediaQuery.of(context).size.height;
    double wight= MediaQuery.of(context).size.width;
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
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(child: Text(TextShow,style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 30),),),
            StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance.collection('AdminData').where('Location',isEqualTo:DataUser!.City).where('TybeMarket',isEqualTo: widget.Tybe,).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                return Column(
                  children: [

                    AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(w / 30),
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              horizontalOffset: -300,
                              verticalOffset: -850,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResturntCollection(
                                        ResturntData: snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                                  height: hight / 3.1,
                                  width: wight * 95 / 100,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 13,
                                        offset: const Offset(5, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: hight / 6,
                                            width: wight * 95,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!.docs[index]['ImageProfile'],
                                                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          snapshot.data!.docs[index]['Offar'] > 0
                                              ? Container(
                                            width: w / 3,
                                            height: hight / 8.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.teal.withOpacity(0.5),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'خصومات بقيمة',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                                Text(
                                                  '₪ ${snapshot.data!.docs[index]['Offar']}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 25),
                                                ),
                                                const Text(
                                                  'على اصناف مختارة',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          )
                                              : const SizedBox(height: 1, width: 1),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.timelapse, color: Colors.grey, size: 27),
                                                        Text(
                                                          ' ${45}وقت التوصيل',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                    const Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.delivery_dining, color: Colors.grey, size: 27),
                                                        Text(
                                                          '${4.5} ₪',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Icon(Icons.location_on, color: Colors.grey, size: 27),
                                                        Text(
                                                          City[snapshot.data!.docs[index]['Location'] - 1],
                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]['Username'],
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                ),
                                                //Location
                                                const Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.star, color: Color(0xFFFFD700), size: 27),
                                                    Text(
                                                      '4.5',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                );
              },
            )/*:Container(
              color: Colors.white,
          child: Center(child: Container(
                  color: Colors.white,
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.green,)),),
        ),*/
          ],
        )),
      ),
    );
  }
}
