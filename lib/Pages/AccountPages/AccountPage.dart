import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/AccountPages/AccountEditData.dart';
import 'package:halaapp/Pages/AccountPages/AccountEditLocation.dart';
import 'package:halaapp/models/snack.dart';
import 'package:provider/provider.dart';

import '../LogInPage/AddLocation.dart';
import '../LogInPage/SinInPage.dart';
import '../../provider/DataUser.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}
List<String> City = [
  "الخليل",
  "نابلس",
  "طولكرم",
  "يطا",
  "جنين",
  "البيرة",
  "دورا",
  "رام الله",
  "الظاهرية",
  "قلقيلية",
  "بيت لحم",
  "طوباس",
  "سلفيت",
  "بيت جالا",
  'بيت ساحور'
];
void signOut({required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogIn()));
    showSnackBar(context: context, text: 'تم تسجيل الخروج', color1: Colors.blue);
  } catch (e) {
    showSnackBar(context: context, text: 'حدث خطأ أثناء تسجيل الخروج: $e', color1: Colors.blue);

  }
}

class _AccountPageState extends State<AccountPage> {
  getDataFromDB() async {
    Userdata userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }
  @override
  void initState() {
    getDataFromDB();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final DataUser = Provider.of<Userdata>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Img/logowelcome.png'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(56, 95, 172, 1),
                Color.fromRGBO(1, 183, 168, 1)
              ]
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50,bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                margin: const EdgeInsets.only(left: 15,right: 15),
                height:h/4.5,
                decoration: BoxDecoration(gradient: const LinearGradient(
                  begin: Alignment.topRight,end: Alignment.bottomLeft,
                  colors: [
                    Colors.cyan,
                    Colors.teal
                  ]
                ),borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DataUser!.Name,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        const Text(': الاسم',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DataUser.PhoneNumber,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        const Text(': الرقم',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DataUser.EmailAddress,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        const Text(': البريد الالكتروني',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditData(
                          Name:DataUser.Name,
                          Email:DataUser.EmailAddress ,
                          Phone:DataUser.PhoneNumber ,
                        ),));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white,width: 3)
                        ),
                        width: w*0.3,
                        height: h/20,
                        child: const Center(child: Text('تعديل البيانات',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                    )
                  ],
                ),
              ),
              const Text('العنوان الحالي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black)),
              Container(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                margin: const EdgeInsets.only(left: 15,right: 15),
                height:h/2.5,
                decoration: BoxDecoration(gradient: const LinearGradient(
                    begin: Alignment.topRight,end: Alignment.bottomLeft,
                    colors: [
                      Colors.cyan,
                      Colors.teal
                    ]
                ),borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(City[DataUser.City-1],style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        const Text(': المدينة',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(DataUser.Dis,style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        const Text(': العنوان',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      height: h/4.8,width: w*0.9,
                      child:AddLocation(WhichPage: false),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditLocation(WhichPage: true),));

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white,width: 3)
                        ),
                        width: w*0.3,
                        height: h/20,
                        child: const Center(child: Text('تعديل العنوان',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) =>
                    AlertDialog(content:
                    Container(
                      color: Colors.white,
                      height: h/5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('هل أنت متأكد؟'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(onPressed: (){
                                signOut(context: context);
                              },
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text('نعم',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: const Text('لا',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                    )
                    ,);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.red,
                        Colors.orangeAccent
                      ]
                    )
                  ),
                  width: w*0.4,
                  height: h/16,
                  child: const Center(child: Text('تسجيل الخروج',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
