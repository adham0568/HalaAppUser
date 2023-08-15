import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/TotalPrudact.dart';

class CartWidget extends StatefulWidget {
  double h;
  double w;
  CartWidget({Key? key,required this.h,required this.w}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}
bool Change=false;
class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final Provaider1 = Provider.of<total>(context);
    setState(() {
      Provaider1.Num1()>0?Change=true:Change=false;
    });
    return Center(
        child: Stack(
          children: [
            Container(
              height: widget.h,width:widget.w,
              decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 0.01,
                    offset: Offset(3,4)
                )
              ]
              ),
              child:Change?Icon(CupertinoIcons.bag_fill,size: widget.h*0.6,color: Colors.teal,):Icon(CupertinoIcons.bag,size: widget.h*0.6,),
            ),
            Positioned(
                bottom: widget.h*0.13,
                left: widget.w/3.5,
                child:
                Container(
                  height: widget.h/2.5,
                  width: widget.w/2.5,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      color:Colors.white ,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal,
                            spreadRadius: 0.01,
                            offset: Offset(2,3)
                        )
                      ]
                  ),
                  child:Center(
                    child: Consumer<total>(
                      builder: (context, value, child) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 300), // مدة الانتقال بالمللي ثانية
                          child: Center(
                            child: Text(
                              value.Num1().toString(),
                              key: ValueKey<int>(value.Num1()), // يجب تحديد مفتاح فريد لكل نص
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:Colors.red,
                                fontSize:widget.h*0.25,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ))
          ],
        ),
      );
  }
}
