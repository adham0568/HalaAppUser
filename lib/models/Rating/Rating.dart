import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Raiting extends StatefulWidget {
  double SizeStar;
  Raiting({required this.SizeStar,Key? key}) : super(key: key);

  @override
  State<Raiting> createState() => _RaitingState();
}
int Rate=0;
class _RaitingState extends State<Raiting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
              size: widget.SizeStar,
            ),
          );
        }),
      ),
    );
  }
}
