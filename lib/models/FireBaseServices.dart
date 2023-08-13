import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseServices{
  Future<void> sendListToFirestore({required int IdOrdar,required int calculateTotalPrice,required List<Map<String, dynamic>> formattedList,required String Uid}) async {
    CollectionReference listItem = FirebaseFirestore.instance.collection('Ordar');
    Map<String, dynamic> orderData = {
      'orderID': IdOrdar, // قم بتعيين الـ ID الخاص بالطلب هنا
      'totalPrice': '$calculateTotalPrice ₪',
      'items': formattedList,
      'OrdarStates': 0,
      'User':Uid,
    };

    listItem
        .doc('$IdOrdar')
        .set(orderData)
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));

    print('تم إرسال القائمة والبيانات الإضافية بنجاح إلى Firestore');
  }
}