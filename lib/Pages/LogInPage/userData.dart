import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String Name;
  String EmailAddress;
  String Password;
  String Uid;
  List Ordar;
  List TotalPrise;
  double Lat;
  double Long;
  int City;
  String Dis;
  String PhoneNumber;
  String Token;


  UserData(
      {
        required this.EmailAddress,
        required this.Name,
        required this.Password,
        required this.Uid,
        required this.Ordar,
        required this.TotalPrise,
        required this.Lat,
        required this.Long,
        required this.City,
        required this.Dis,
        required this.PhoneNumber,
        required this.Token,
      });

  //convert data frome UserData to  Map<String,Object>


  Map<String, dynamic> Convert2Map(){
    return {
      'Name':Name,
      'EmailAddress':EmailAddress,
      'Password':Password,
      'Uid':Uid,
      'Ordar':[],
      'TotalPrise':[],
      'Lat':Lat,
      'Long':Long,
      'City':City,
      'Dis':Dis,
      'PhoneNumber':PhoneNumber,
      'Token':Token,
    };
  }

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      EmailAddress: snapshot["EmailAddress"],
      Name: snapshot["Name"],
      Password: snapshot["Password"],
      Uid: snapshot["Uid"],
      Ordar: snapshot["Ordar"],
      TotalPrise: snapshot["TotalPrise"],
      Lat:snapshot['Lat'] ,
      Long: snapshot['Long'],
      City: snapshot['City'],
      Dis:snapshot['Dis'],
      PhoneNumber:snapshot['PhoneNumber'],
      Token:snapshot['Token']
    );
  }


}