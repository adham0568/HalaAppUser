import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/Rating/Rating.dart';
import 'package:halaapp/models/Support/FireBaseStatment.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}
DocumentSnapshot? snapshot1;
final Send = TextEditingController();
firebaseStatment DataBase=firebaseStatment();
List? Massege;
class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: h/30),
                height: h/10,
                width:w*0.98,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),bottomLeft:Radius.circular(15)),border: Border.all(width: 2,color: Colors.grey)),
                child: Center(child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (context) =>
                            AlertDialog(
                              content: Container(
                                height: 150,color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('هل انت متأكد من مغادرة المحادثة ؟',style: TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black54
                                    ),),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(onPressed: () async {
                                          /* await DataBase.DeleteMassage(context: context);*/
                                          Navigator.pop(context);
                                          showDialog(context: context, builder: (context) => AlertDialog(
                                            content: Container(
                                              height: h/3,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('الرجاء تقييم المحادثة',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: w/20),),
                                                  Raiting(SizeStar: 35),
                                                  InkWell(
                                                    onTap: () {
                                                      DataBase.EndChat(
                                                        context: context,
                                                        massege:snapshot1!['Massege'],
                                                        Name: snapshot1!['Name'],
                                                        Time: snapshot1!['Time'],
                                                        Rate: Rate,
                                                      );
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: h/16,
                                                      width: w*0.4,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          gradient: LinearGradient(
                                                              begin: Alignment.topRight,
                                                              end: Alignment.bottomLeft,
                                                              colors: [
                                                                Color.fromRGBO(141, 0, 210, 1),
                                                                Color.fromRGBO(255, 97, 38, 1)
                                                              ]
                                                          )
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'إرسال',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),);
                                        }, child: Text("نعم",style: TextStyle(
                                            color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                                        ),),
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                        ),
                                        ElevatedButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: Text("لا",style: TextStyle(
                                            color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold
                                        ),),
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ,);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(141, 0, 210, 1),
                              Color.fromRGBO(255, 97, 38, 1)
                            ]
                          )
                        ),
                        margin: EdgeInsets.only(left: 15),
                        width: w/6,
                        height: w/10,
                        child: Center(child: Text('مغادرة',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),),
                    ),
                    SizedBox(width: 80,),
                    Text('الدعم الفني',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.grey),),
                  ],
                )),
              ),
             Container(
               height: h*0.85,
               child: Stack(
                 children: [
                   StreamBuilder<DocumentSnapshot>(
                     stream: FirebaseFirestore.instance.collection('SupportData').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                       if (snapshot.hasError) {
                         return Text('حدث خطأ أثناء جلب البيانات');
                       }

                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return Text('جاري التحميل...');
                       }

                       if (!snapshot.hasData || !snapshot.data!.exists) {
                         return Text('لا يوجد بيانات');
                       }
                       snapshot1=snapshot.data!;
                       Massege=snapshot.data!['Massege'];
                       return Container(
                           height:  h*0.7,
                           child:ListView.builder(
                             physics: ClampingScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: snapshot.data!['Massege'].length,
                             itemBuilder: (context, index) =>  Align(
                               alignment:snapshot.data!['Massege'][index]['Which']==1? Alignment.centerRight: Alignment.centerLeft,
                               child: Container(
                                 width: w/2,
                                 padding: EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                                 margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                 decoration: BoxDecoration(
                                     gradient: LinearGradient(
                                         begin: Alignment.topRight,
                                         end: Alignment.bottomLeft,
                                         colors:snapshot.data!['Massege'][index]['Which']==1? [
                                           Color.fromRGBO(56, 95, 172, 1),
                                           Color.fromRGBO(1, 183, 168, 1)
                                         ]
                                             :
                                         [
                                           Color.fromRGBO(141, 0, 210, 1),
                                           Color.fromRGBO(255, 97, 38, 1)
                                         ]
                                     ),
                                     borderRadius: BorderRadius.only(
                                       topRight: Radius.circular(30),
                                       bottomLeft: Radius.circular(30),
                                       bottomRight: Radius.circular(5),
                                       topLeft: Radius.circular(5),
                                     )),
                                 child: Center(child: Text(snapshot.data!['Massege'][index]['Massege'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
                               ),
                             ),)
                       );
                     },
                   ),

                   Positioned(
                     bottom: 0,
                     right: 0,
                     left: 0,
                     child: Column(
                       children: [
                         Container(
                           width: w*0.8,
                           child: TextFormField(
                             style: TextStyle(fontSize: 25,color: Colors.black45,fontWeight: FontWeight.bold),
                             decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                               suffixIcon:InkWell(
                                 onTap: () async {
                                   print(Massege);
                                   await firebaseStatment().SendMassege(massege: Send.text, Which: 0,Massage:Massege!);
                                   Send.text='';
                                 },
                                 child: Container(
                                   margin: EdgeInsets.only(left: 10,right: 10),
                                   width: w/5,
                                   height: h/20,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                       gradient: LinearGradient(
                                           begin: Alignment.topRight,
                                           end: Alignment.bottomLeft,
                                           colors: [
                                             Color.fromRGBO(56, 95, 172, 1),
                                             Color.fromRGBO(1, 183, 168, 1)
                                           ]
                                       )
                                   ),
                                   child: Center(child: Text('إرسال',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),
                                 ),
                               ),
                             ),
                             controller:Send,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
/**/