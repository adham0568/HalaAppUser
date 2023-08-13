import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/LogInPage/AddLocation.dart';
import 'package:halaapp/Pages/LogInPage/AuthMethod.dart';
import 'package:halaapp/Pages/LogInPage/SinInPage.dart';
import 'package:halaapp/models/snack.dart';

import '../../models/HIGHT.dart';

class SingUP extends StatefulWidget {


  double Lat;
  double Long;
  bool LocationAdd;
  String Dis;
  int City;
  SingUP({Key? key,required this.Lat,required this.Long,required this.LocationAdd,required this.Dis,required this.City}) : super(key: key);

  @override
  State<SingUP> createState() => _SingUPState();
}
final email = TextEditingController();
final pass = TextEditingController();
final name = TextEditingController();
final Phone_Number = TextEditingController();


double contenershaplogin1=0;
Icon? icona;
bool singupwating=true;
bool singup=false;





class _SingUPState extends State<SingUP> {

  AuthMethod Auth=AuthMethod();
  bool Showpass=true;
  @override
  Widget build(BuildContext context) {
    SizeFix Size=SizeFix();
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,colors: [
          Colors.white,
          Colors.grey,
        ])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){print(widget.City);}, child: const Text('Test')),
              Container(
                padding: const EdgeInsets.only(top: 28),
                height: 200,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Image.asset(
                          'assets/Img/logowelcome.png',height: 150,fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:10,left: 10,right: 10),
                height: Size.Hight(context: context)/1.3,
                width: 500,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(63, 178, 169, 10),
                                    Color.fromRGBO(0, 193, 160, 10),
                                  ])),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds:300,),
                                top: contenershaplogin1,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromRGBO(63, 186, 255, 10),
                                          Color.fromRGBO(0, 255, 93, 10),
                                        ]),),
                                  child: icona,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 270,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: name,
                                onTap: (){
                                  setState(() {
                                    contenershaplogin1=0;
                                    icona=const Icon(Icons.account_circle,color: Colors.white,);
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'الاسم',
                                  labelStyle: const TextStyle(color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.teal.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            SizedBox(
                              width: 270,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onTap: (){
                                  setState(() {
                                    contenershaplogin1=90;
                                    icona=const Icon(Icons.email_outlined,color: Colors.white,);
                                  });
                                },
                                controller: email,
                                decoration: InputDecoration(
                                  hintText: 'البريد الالكتروني',
                                  labelStyle: const TextStyle(color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.teal.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            SizedBox(
                              width: 270,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged:(pass) {
                                  setState(() {
                                    if(pass.length>=8){singup=true;}
                                    else{singup=false;}
                                  });
                                },
                                onTap: (){
                                  setState(() {
                                    contenershaplogin1=170;
                                    icona=const Icon(Icons.password,color: Colors.white,);
                                  });
                                },
                                controller: pass,
                                obscureText: Showpass,
                                decoration: InputDecoration(
                                  hintText: 'كلمة السر',
                                  labelStyle: const TextStyle(color: Colors.teal),
                                  suffixIcon: IconButton(onPressed: (){
                                    setState(() {
                                      Showpass=!Showpass;
                                    });
                                  },icon:Showpass?const Icon(CupertinoIcons.eye_fill):const Icon(CupertinoIcons.eye_slash_fill),color: Colors.teal.shade300,),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.teal.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                            SizedBox(
                              width: 270,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: Phone_Number,
                                onTap: (){
                                  setState(() {
                                    contenershaplogin1=250;
                                    icona=const Icon(Icons.phone,color: Colors.white,);
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'رقم الهاتف',
                                  labelStyle: const TextStyle(color: Colors.teal),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal.shade300),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.teal.shade300),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 15,),

                    const SizedBox(height: 30,),
                    widget.LocationAdd?Container(
                      child:singup? Container(
                        child: singupwating
                            ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              singupwating = false;
                              Timer(const Duration(seconds: 2), () {
                                                  Auth.SingUp(
                                                    PhoneNumber: Phone_Number.text,
                                                    Name: name.text,
                                                    Email: email.text,
                                                    Ordar: [],
                                                    Password: pass.text,
                                                    TotalPrise: [],
                                                    City:widget.City,
                                                    Lat:widget.Lat,
                                                    context:context,
                                                    Dis:widget.Dis,
                                                    Lng:widget.Long,
                                                  );
                                 singupwating = true;
                                singup=false;
                              }
                              );
                              singupwating = false;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.teal.shade300)),
                          child: const Text('SingUp'),
                        )
                            : const CircularProgressIndicator(),
                      ):Container(
                        child: ElevatedButton(
                          onPressed: (){
                            showSnackBar(context: context, text: 'الرجاء ادخال معلومات صحيحة', color1: Colors.red);
                          },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                          child: const Text('SingUP',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ):
                    InkWell(
                      onTap: (){ showSnackBar(context: context, text: 'سيتم تحديد موقعك تلقائياً', color1: const Color.fromRGBO(2, 149, 193, 50));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddLocation(WhichPage: true),));},
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(56, 95, 172, 1),
                              Color.fromRGBO(1, 183, 168, 1)
                            ])),
                        height: 60,
                        child: const Center(child: Text('تحديد موقعك',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogIn()));
                        }, child: const Text('تسجيل الدخول الان',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18),)),
                        const Text('هل لديك حساب بلفعل؟',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ],
                    )
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
