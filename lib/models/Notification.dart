import 'dart:convert';

import 'package:http/http.dart' as http;
final String serverToken ='AAAA_AIFDMU:APA91bGndgfYtWMz6-BKNGdzjudhRoau3L1JwQZdpO9EQ2QqjPiP-uIC6E9dewVhmPqZJB54ExvumpHnySFSvqNqfMDK9bFWxbtPNsbVOQFxk1Bf_z-iK1O7QRNGEU25vOuPfWT0oVek';


class Notificasion{
  Future<void> sendNotificationUsingServerToken(
      {required String title,required String body,required String Token,}) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken', // استبدل بـ serverToken الخاص بك
    };

    final message = {
      'notification': {
        'title': title,
        'body': body,
      },
      'priority': 'high',
      'data': {
      },
      'to': '${Token}', // يمكنك استبدالها بالـ FCM token المستهدف أو "/topics/{topic}" لاستهداف موضوع معين
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(message),
      );

      if (response.statusCode == 200) {
        print('تم إرسال الإشعار بنجاح');
      } else {
        print('حدث خطأ أثناء إرسال الإشعار: ${response.statusCode}');
      }
    } catch (e) {
      print('حدث خطأ أثناء إرسال الإشعار: $e');
    }
  }
}