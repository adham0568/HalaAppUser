

import 'package:flutter/material.dart';

class SizeFix{
  double wight({required BuildContext context}){
    return  MediaQuery.of(context).size.width;
  }

  double Hight({required BuildContext context}){
    return  MediaQuery.of(context).size.height;
  }
}