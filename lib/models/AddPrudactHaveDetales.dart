import 'package:flutter/material.dart';
import 'package:halaapp/Pages/appPages/Sections/Restaurant/AddPrudactToCart.dart';

class AddToCartResturant extends StatefulWidget {
  Map Prudact;
  AddToCartResturant({Key? key,required this.Prudact}) : super(key: key);

  @override
  State<AddToCartResturant> createState() => _AddToCartResturantState();
}
class _AddToCartResturantState extends State<AddToCartResturant> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddToCartResturant1(Prudact1: widget.Prudact),));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(56, 95, 172, 180),
                  Color.fromRGBO(1, 183, 168, 180)
                ]
            )
        ),
        child: const Text("إضافة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
      ),
    );
  }
}
