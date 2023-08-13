import 'package:flutter/material.dart';


showSnackBar({required BuildContext context,required String text,required Color color1}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color1,
    duration: const Duration(seconds: 1),
    content: Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    action: SnackBarAction(label: "اغلاق", onPressed: () {},textColor: Colors.white),
  ));
}
