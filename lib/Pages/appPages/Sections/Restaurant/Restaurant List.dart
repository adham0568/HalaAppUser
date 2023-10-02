import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:halaapp/Pages/RatingPages/RatingWidget.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/ResturantCollection.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
import 'package:halaapp/models/snack.dart';
import 'package:provider/provider.dart';
import '../../../../provider/CartProvider.dart';
import '../../../../provider/DataUser.dart';
import '../Hala/MarketPage.dart';

class RestaurantList extends StatefulWidget {
  bool Which;
   RestaurantList({Key? key,required this.Which}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}
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
class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    final Provaider = Provider.of<CartProvider>(context);
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
           widget.Which? Column(
             children: [
               Container(
                 child: const Text('خصومات على اصناف مختارة',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black54),),
               ),
               ElevatedButton(onPressed: () {
                 setState(() {
                   widget.Which=false;
                 });
               },style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(Colors.teal)
               ), child: const Text('تراجع'),)
             ],
           ):Container(

              margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        Section=3;
                        SelectSection=true;
                      });
                    },
                    child:Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: hight/8,
                        width: wight/4.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(56, 95, 172, 1), Color.fromRGBO(1, 183, 168, 1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // لون الظل
                              spreadRadius: 2, // نسبة انتشار الظل
                              blurRadius: 10, // نسبة ضبابية الظل
                              offset: const Offset(7, 5), // اتجاه الظل (الإنحراف الأفقي والعمودي)
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/Img/icons8-burger-100.png',color: Colors.white,height: hight/19,),
                            const Text(
                              'برجر',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        Section=4;
                        SelectSection=true;
                      });
                    },
                    child:Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: hight/8,
                        width: wight/4.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(56, 95, 172, 1), Color.fromRGBO(1, 183, 168, 1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // لون الظل
                              spreadRadius: 2, // نسبة انتشار الظل
                              blurRadius: 10, // نسبة ضبابية الظل
                              offset: const Offset(7, 5), // اتجاه الظل (الإنحراف الأفقي والعمودي)
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.local_pizza_outlined, size: hight/19, color: Colors.white),
                            const Text(
                              'بيتزا',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showSnackBar(context: context, text: 'سيتم توفير هذا الخيار قريباً', color1: Colors.teal);
                    },
                    child:Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: hight/8,
                        width: wight/4.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(56, 95, 172, 1), Color.fromRGBO(1, 183, 168, 1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // لون الظل
                              spreadRadius: 2, // نسبة انتشار الظل
                              blurRadius: 10, // نسبة ضبابية الظل
                              offset: const Offset(7, 5), // اتجاه الظل (الإنحراف الأفقي والعمودي)
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.handshake, size: hight/19, color: Colors.white),
                            const Text(
                              'اعمال الخير',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        widget.Which=true;
                      });
                    },
                    child:Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        height: hight/8,
                        width: wight/4.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(56, 95, 172, 1), Color.fromRGBO(1, 183, 168, 1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // لون الظل
                              spreadRadius: 2, // نسبة انتشار الظل
                              blurRadius: 10, // نسبة ضبابية الظل
                              offset: const Offset(7, 5), // اتجاه الظل (الإنحراف الأفقي والعمودي)
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.percent, size: hight/19, color: Colors.white),
                            const Text(
                              'عروض',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             StreamBuilder<QuerySnapshot>(
          stream:widget.Which?
          FirebaseFirestore.instance.collection('AdminData').where('Location',isEqualTo:DataUser!.City).where('Offar',isGreaterThan: 0,).snapshots()
              :
          SelectSection?
          FirebaseFirestore.instance.collection('AdminData').where('Location',isEqualTo:DataUser!.City).where('TybeMarket',isEqualTo: Section).snapshots()
              :
          FirebaseFirestore.instance.collection('AdminData').where('Location',isEqualTo:DataUser!.City).where('TybeMarket',isLessThan: 10).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(context: context, builder: (context) => Container(
                        color: Colors.white,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:Tybe.length ,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              setState(() {
                                SelectSection=true;
                                Navigator.pop(context);
                              });
                              Section=index;
                              print(Section);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black26,),
                              child: Center(child: Text(Tybe[index],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                            ),
                          ),),
                      ),
                    );
                  },
                  child:widget.Which? const SizedBox(height: 1,width: 1,):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:SelectSection? Colors.green:Colors.black26,),
                        width: w/2.5,height: w/8.5,
                        margin: const EdgeInsets.only(top: 20),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SelectSection?const Text(''):const Icon(Icons.menu,color: Colors.white,size: 25,),
                              Text(SelectSection?Tybe[Section!]:'التصنيف',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                              SelectSection? IconButton(onPressed: () {
                                setState(() {
                                  SelectSection=false;
                                });
                              }, icon: const Icon(Icons.cancel_outlined,color: Colors.red,)):const Text(''),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(
                              Product: [],
                              Name: 'مطاعم',whichPage: 0,NamePrudact: '',),));
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:Colors.black26,),
                          width: w/2.5,height: w/8.5,
                          margin: const EdgeInsets.only(top: 20),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20,right: 20),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.search,color: Colors.white,size: 30,),
                                Text('بحث',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
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
                            Provaider.token=snapshot.data!.docs[index]['Token'];
                            print(Provaider.token);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => marketPage(DataRestaurnat: snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                              idAdmin: '',
                              whichPage: 1,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            height: hight / 3,
                            width: wight * 0.95,
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
                                SizedBox(
                                  height: w / 3.5,
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
                                  padding: EdgeInsets.symmetric(horizontal: w/17),
                                  width: w ,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.pink.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'على اصناف مختارة',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: w/23),
                                      ),
                                      Text(
                                        '₪ ${snapshot.data!.docs[index]['Offar']}',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent, fontSize: w/20),
                                      ),
                                      Text(
                                        'خصومات بقيمة',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: w/23),
                                      ),
                                    ],
                                  ),
                                )
                                    : const SizedBox(height: 1, width: 1),
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
                                               Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.timelapse, color: Colors.grey, size: w/18),
                                                  Text(
                                                    ' ${45}وقت التوصيل',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/24),
                                                  )
                                                ],
                                              ),
                                               Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delivery_dining, color: Colors.grey, size: w/18),
                                                  Text(
                                                    '${snapshot.data!.docs[index]['Offar']} ₪',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/24),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                   Icon(Icons.location_on, color: Colors.grey, size: w/18),
                                                  Text(
                                                    City[snapshot.data!.docs[index]['Location'] - 1],
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/24),
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
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/24),
                                          ),
                                          Text(
                                            Tybe[snapshot.data!.docs[index]['TybeMarket']],
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: w/24),
                                          ),
                                          //Location
                                          RatingWidget(idMarket: snapshot.data!.docs[index]['Uid']),
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
