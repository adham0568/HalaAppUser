import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Raiting extends StatefulWidget {
  Raiting({Key? key}) : super(key: key);

  @override
  State<Raiting> createState() => _RaitingState();
}
int Rate=0;



class _RaitingState extends State<Raiting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final isFilled = index < Rate;
          return IconButton(
            onPressed: () {
              setState(() {
                Rate = index + 1;
              });
            },
            icon: Icon(
              isFilled ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: 35,
            ),
          );
        }),
      ),
    );;
  }
}
