import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  String idMarket;
  RatingWidget({required this.idMarket,Key? key}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int rate=0;
  double o=0;
  bool ValueGet=false;
  String NullRate='';
  bool NullRate1=false;
  Future<void> getRating() async {
      rate=0;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('AdminData').doc(widget.idMarket).collection('Raiting').doc('0').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        List ratingData =data['Rating'];
        for(int i=0;i<ratingData.length;i++){
          int rating=ratingData[i]['RateStars'];
          rate+=rating;
        }
        o=rate/ratingData.length;
        setState(() {
          ValueGet=true;
          NullRate1=true;
        });
      } else {
        setState(() {
          ValueGet=true;

          NullRate1=false;
        });
        NullRate='لا يوجد تقييم';
        print("No documents found");
      }

  }

  @override
  void initState() {
    getRating();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;
    return ValueGet? Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Color(0xFFFFD700), size: w/18),
        Text(
          NullRate1?o.toString().substring(0,3):NullRate,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:NullRate1? w/24:w/35),
        )
      ],
    )
        :
        CircularProgressIndicator()
    ;

  }
}
