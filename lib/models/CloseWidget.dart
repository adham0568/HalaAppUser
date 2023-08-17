import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseWidget extends StatefulWidget {
  double w;
  bool icon;//true=close//false=back
  CloseWidget({required this.icon,Key? key,required this.w}) : super(key: key);

  @override
  State<CloseWidget> createState() => _CloseWidgetState();
}

class _CloseWidgetState extends State<CloseWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {Navigator.pop(context);},
      child: Container(
        height:widget.w*0.1,
        width: widget.w*0.1,
        decoration: BoxDecoration(
            shape: BoxShape.circle,color: Colors.white,
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
        child: Transform.scale(
          scale: 1.5,
          child: Icon(
            widget.icon?Icons.close_sharp:CupertinoIcons.back,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
