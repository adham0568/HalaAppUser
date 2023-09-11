import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/SearchPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ImageAnimation extends StatefulWidget {
  List AddList=[];
  List Product;
  ImageAnimation({required this.AddList,required this.Product,Key? key}) : super(key: key);

  @override
  State<ImageAnimation> createState() => _ImageAnimationState();
}
class _ImageAnimationState extends State<ImageAnimation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  items: widget.AddList.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return AspectRatio(
                          aspectRatio: 100 / 10, // تحديد نسبة العرض إلى الارتفاع هنا
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  SearchPage(Product: widget.Product,whichPage: 2, Name:widget.AddList[_currentIndex]['ProductName'],NamePrudact:widget.AddList[_currentIndex]['ProductName']),));
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
                  count:widget.AddList.length,
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
    );
  }
}
