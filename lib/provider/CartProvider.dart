import 'package:flutter/material.dart';
import '../models/Item.dart';

class CartProvider with ChangeNotifier {
  List<Item> Products = [];
  String xid1 = '000';
  String token='00';

  final int _ItemsCount = 0;
  int NumOfPrudact=0;
  List IdPrudacts=[];
  addPrudact({required Item item}){
    IdPrudacts.add(item.IdPrudact);
  }
  removePrudact({required Item item}){
    IdPrudacts.remove(item.IdPrudact);
  }



  AddToCart({required Item item}) {
    Products.add(item);
  }

  RemoveToCart(Item item,int idToDelete) {
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].IdPrudact == idToDelete /*&&Products[i].OpitionSelected==item.OpitionSelected*/) {
        Products.removeAt(i);
        break;
      }
    }
  }

  List<Item> listitem() {
    List<Item> result = [];
    Map<int, List<Item>> productsMap = {};

    for (Item item in Products) {
      if (!productsMap.containsKey(item.IdPrudact)) {
        productsMap[item.IdPrudact] = [item];
      } else {
        List<Item> existingItems = productsMap[item.IdPrudact]!;
        bool shouldAdd = true;

        for (Item existingItem in existingItems) {
          if (existingItem.IdPrudact == item.IdPrudact/*existingItem.OpitionSelected == item.OpitionSelected*/) { /*الحل الصحيح هو existingItem.IdPrudact == item.IdPrudact*/
            shouldAdd = false;
            break;
          }
        }

        if (shouldAdd) {
          existingItems.add(item);
        }
      }
    }

    productsMap.values.forEach((items) => result.addAll(items));

    return result;
  }
  GetNumberByProducts(Item item) {
    int Numproducts = 0;
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].IdPrudact == item.IdPrudact/* && Products[i].OpitionSelected==item.OpitionSelected*/) {
        Numproducts++;
      }
    }
    return Numproducts;
  }
  Clear(){
    Products.clear();
    listitem().clear();
    notifyListeners();
  }

  bool bool_In({required int Id}){
    bool In=false;
    for(int i=0;i<IdPrudacts.length;i++){
      if(IdPrudacts[i]==Id){
        In=true;
        break;
      }
    }
    return In;
  }


  double PirseCalculating(){
    double Prise=0;
    for(int i=0;i<Products.length;i++){
      double _prise=Products[i].Prise;
      Prise+=_prise;
    }

// تحديد عدد الأرقام العشرية التي تريد عرضها (في هذه الحالة، 1)
    int decimalPlaces = 1;

// تحويل الرقم إلى نص مع تقليل عدد الأرقام العشرية
    String formattedNumber = Prise.toStringAsFixed(decimalPlaces);

// تحويل النص المنسق إلى رقم مرة أخرى إذا كنت بحاجة إلى ذلك
    double finalNumber = double.parse(formattedNumber);

    return finalNumber;
  }
}

