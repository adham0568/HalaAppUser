import 'package:flutter/material.dart';
import '../models/Item.dart';

class CartProvider with ChangeNotifier {
  List<Item> Products = [];
  String xid1 = '000';
  //String get xid => xid1;


 /* void updateXID(String newXID) {
    xid1 = newXID;
    notifyListeners();
  }*/

  int price = 0;
  final int _ItemsCount = 0;
  List IdPrudacts=[];
  int NumOfPrudact=0;




  addPrudact({required Item item}){
    IdPrudacts.add(item.IdPrudact);
  }
  removePrudact({required Item item}){
    IdPrudacts.remove(item.IdPrudact);
  }



  AddToCart({required Item item}) {
    if(Products.isNotEmpty){
      if(Products.first.IdMarket==item.IdMarket)
      {Products.add(item);
      price += item.Prise;
      }
      else{Products.clear();
        price=0;
        Products.add(item);
      price+= item.Prise;
      }
    }
   else if(Products.isEmpty){
      Products.add(item);
      price += item.Prise;
    }
  }

  RemoveToCart(Item item,int idToDelete) {
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].IdPrudact == idToDelete) {
        Products.removeAt(i);
        price -= item.Prise;
        break;
      }
    }
  }

  List<Item> listitem() {
    List<Item> result = [];
    Set<int> seenIds = <int>{};
    for (Item item in Products) {
      if (!seenIds.contains(item.IdPrudact)) {
        result.add(item);
        seenIds.add(item.IdPrudact);
      }
    }

    return result;
  }

  GetNumberByProducts(Item item) {
    int Numproducts = 0;
    for (int i = 0; i < Products.length; i++) {
      if (Products[i].IdPrudact == item.IdPrudact) {
        Numproducts++;
      }
    }
    return Numproducts;
  }
  Clear(){
    Products.clear();
    listitem().clear();
    price=0;
    notifyListeners();
  }
}
//
