import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/PrudactRestaurant.dart';

class Discaount extends StatefulWidget {
  String UidAdmin;
  Discaount({Key? key,required this.UidAdmin}) : super(key: key);

  @override
  State<Discaount> createState() => _DiscaountState();
}

class _DiscaountState extends State<Discaount> {
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
      body: Container(
        margin: const EdgeInsets.all(15),
        child:  GridViewRust(Prudact:const {},Swich: false,Uid:widget.UidAdmin ),
      )
    );
  }
}
