import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ImageAnimation2 extends StatefulWidget {
  String DocumantName;
  ImageAnimation2({required this.DocumantName,Key? key}) : super(key: key);

  @override
  State<ImageAnimation2> createState() => _ImageAnimation2State();
}
int _currentIndex = 0;
List? images;
bool waiting=false;
class _ImageAnimation2State extends State<ImageAnimation2> {
  Future<Map<String, dynamic>?> GetDataFromFireBase() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('Pohto add').doc(widget.DocumantName).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        setState(() {
          images = data['Images']; // قم بتعيين القائمة images بقيمة images المسترجعة من Firestore
          waiting = true;
        });
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  @override
  void initState() {
    GetDataFromFireBase();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return waiting?
    Column(
      children: [
        Center(
          child: Container(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex= index;
                      });
                    },
                  ),
                  items: images!.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return AspectRatio(
                          aspectRatio: 100 / 10, // تحديد نسبة العرض إلى الارتفاع هنا
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(whichPage: true, Name: 'Name',NamePrudact:imagePath['PrudactName'] ),));
                              print(imagePath['PrudactName']);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              padding: const EdgeInsets.only(top: 40, bottom: 40),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: imagePath['ImageUrl'],
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.red)),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count:images!.length,
                  effect: WormEffect(
                    type: WormType.thin,
                    spacing: 8.0,
                    radius: 8.0,
                    dotWidth: 15.0,
                    dotHeight: 15.0,
                    strokeWidth: 4.0,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.teal,
                    paintStyle: PaintingStyle.fill,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    )
        :
    Container(color: Colors.white,child: const Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.red,),),);
  }
}
