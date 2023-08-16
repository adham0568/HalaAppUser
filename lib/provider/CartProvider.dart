import 'package:flutter/material.dart';
import '../models/Item.dart';

class CartProvider with ChangeNotifier {
  List<Item> Products = [];
  String xid1 = '000';

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
      if (Products[i].IdPrudact == idToDelete) {
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
          if (existingItem.OpitionSelected == item.OpitionSelected) {
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
      if (Products[i].IdPrudact == item.IdPrudact && Products[i].OpitionSelected==item.OpitionSelected) {
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

  int PirseCalculating(){
    int Prise=0;
    for(int i=0;i<Products.length;i++){
      int _prise=Products[i].Prise;
      Prise+=_prise;
    }
    return Prise;
  }
}
//
