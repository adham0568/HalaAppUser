import 'package:flutter/material.dart';

class DiscountWidget extends StatefulWidget {
  double Size1;
  double Prise;
  double Discount;
  DiscountWidget({required this.Prise,required this.Discount,required this.Size1,Key? key}) : super(key: key);

  @override
  State<DiscountWidget> createState() => _DiscountWidgetState();
}
class _DiscountWidgetState extends State<DiscountWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.Size1/4,right: widget.Size1/4,top: widget.Size1/4,bottom: widget.Size1/4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(widget.Size1*(3/4)),color: Colors.pink.withOpacity(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('%${(widget.Discount/widget.Prise*100).round()}',style: TextStyle(fontSize: widget.Size1,fontWeight: FontWeight.bold,color: Colors.pink),),
          SizedBox(width: widget.Size1/6.6,),
          Text('وفر',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),),
          SizedBox(width: widget.Size1/6.6,),
          Icon(Icons.discount,size: widget.Size1,color: Colors.pink.withOpacity(0.8)),
        ],
      ),
    );
  }
}
