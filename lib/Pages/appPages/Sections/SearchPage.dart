import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/appPages/Sections/detalspage.dart';
import 'package:provider/provider.dart';

import '../../../models/add.dart';
import '../../../provider/DataUser.dart';
import 'Restaurant/ResturantCollection.dart';



class SearchPage extends StatefulWidget {
  String NamePrudact;
  String Name;
  bool whichPage;//hala ture//rust false
  SearchPage({required this.whichPage,required this.Name,required this.NamePrudact,Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}
bool Name=false;
final Search =TextEditingController();
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
List<String> Tybe = [
  'شورما',
  'اسماك',
  'افطار',
  'برجر',
  'بيتزا',
  'حلويات',
  'مناقيش',
  'طبخ منزلي',
  'مشروبات',
  'مخبوزات',
  'مكسرات',
  'ملحمة',
  'صيدلية',
];
class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    setState(() {
      Search.text=widget.NamePrudact;
      Name=true;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
      body:SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 25,right: 25,top: 20),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      Search.text.isNotEmpty? Name=true:Name=false;
                    });
                  },
                  controller: Search,
                  style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 20),
                  keyboardType: TextInputType.text,
                  onTap: (){},
                  decoration: InputDecoration(
                    hintText:  'ابحث عن ${widget.Name}',
                    suffixIcon: const Icon(Icons.search_rounded),
                    suffixStyle: const TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Colors.teal.shade300),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Name?
            StreamBuilder<QuerySnapshot>(
              stream:widget.whichPage? FirebaseFirestore.instance.collection('Prudacts').where('IdMarket',isEqualTo: 'C1zSXr7C9DW3MHN9tsbBiNRSu3g2')
                  .where('Name', isGreaterThanOrEqualTo: Search.text).where('Name', isLessThan: '${Search.text}ي')
                  .snapshots()
                  :
              FirebaseFirestore.instance.collection('AdminData').where('Location',isEqualTo:DataUser!.City).
              where('Name', isGreaterThanOrEqualTo: Search.text).where('Name', isLessThan: '${Search.text}ي').
              where('Name',isNotEqualTo:'Hala Mart' )
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(color: Colors.white,child: const Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.red,),),);
                }
                return widget.whichPage?
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      SizedBox(
                        child:AnimationLimiter(
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(w / 60),
                            crossAxisCount: 2,
                            childAspectRatio: 80/90,
                            mainAxisSpacing: 10,
                            children: List.generate(
                              snapshot.data!.docs.length, (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  scale: 1.5,
                                  child: FadeInAnimation(
                                    child: InkWell(
                                      borderRadius:BorderRadius.circular(15),
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Detales(
                                                  Prudact:snapshot.data!.docs[index].data()! as Map,
                                                )));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10,right: 10),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                            border: Border.all(color: Colors.teal,width: 3)),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [

                                                snapshot.data!.docs[index]['Discount']>0?
                                                const Row(children: [
                                                  Icon(CupertinoIcons.gift,size: 15,color: Colors.teal),
                                                  Text('خصم',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.teal),),
                                                ],):const Text(''),


                                                Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot.data!.docs[index]['ImageUrl'],
                                                    placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                                                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                                ),
                                                Positioned(
                                                    bottom: 2,
                                                    left: 25,
                                                    child:Container(decoration: BoxDecoration(color:Colors.black54,borderRadius: BorderRadius.circular(10)),
                                                        child: AddToCartWidget(Prudact:snapshot.data!.docs[index].data()! as Map,
                                                        ColorIcon: Colors.pink,SizeIcon: 30,
                                                        ))
                                                )
                                              ],
                                            ),
                                            Text(snapshot.data!.docs[index]['Name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                            const SizedBox(height: 5,),
                                            snapshot.data!.docs[index]['Discount']>0?
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text:' ₪''${snapshot.data!.docs[index]['Prise']-snapshot.data!.docs[index]['Discount']} / ',
                                                    style: const TextStyle(fontSize: 30,color: Colors.red,fontWeight: FontWeight.bold,), // يمكنك استخدام أسلوب النص الافتراضي
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${snapshot.data!.docs[index]['Prise']} ₪',
                                                        style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 25,color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                )

                                                //Text('${snapshot.data!.docs[index]['Prise']-snapshot.data!.docs[index]['Discount']}'+' ₪',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                              ],
                                            )
                                                :
                                            Text('${snapshot.data!.docs[index]['Prise']} ₪',style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
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
                      ),
                    ],
                  ),
                )
                    :
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(w / 30),
                    physics: const NeverScrollableScrollPhysics(),
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
                              height: h / 3.1,
                              width: w * 95 / 100,
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
                                        height: h / 6,
                                        width: w * 95,
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
                                        height: h/ 8.5,
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
                                            child: const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.timelapse, color: Colors.grey, size: 27),
                                                    Text(
                                                      ' ${45}وقت التوصيل',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.delivery_dining, color: Colors.grey, size: 27),
                                                    Text(
                                                      '${4.5} ₪',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                                              snapshot.data!.docs[index]['Name'],
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                            ),
                                            Text(
                                              Tybe[snapshot.data!.docs[index]['TybeMarket']],
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
                );
              },
            )
                :
            const SizedBox(height: 1,width: 1,),
          ],
        ),
      ),
    );
  }
}
/* FirebaseFirestore.instance.collection('Prudacts').where('IdMarket',isEqualTo: 'C1zSXr7C9DW3MHN9tsbBiNRSu3g2')
                  .where('Name', isGreaterThanOrEqualTo: Search.text).where('Name', isLessThan: Search.text + 'ي')
                  .snapshots(),*/