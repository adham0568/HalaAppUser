import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/LogInPage/AuthMethod.dart';
import 'package:provider/provider.dart';
import '../../models/snack.dart';
import '../../provider/GoogelProvider.dart';
import 'singUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

final emailAddress = TextEditingController();
final password = TextEditingController();
bool ShowPassword = true;
bool nextpage = false;
bool singin=false;
double contenershaplogin=0;
bool iconcount=true;
bool loginloding=true;
String? email;
class _LogInState extends State<LogIn> {



  @override
  Widget build(BuildContext context) {
    AuthMethod Auth=AuthMethod();
    final GoogleProviderSignIn = Provider.of<GoogleSignInProvider>(context);


    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 330,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Transform.translate(
                              offset: const Offset(-10, -10),
                              child: Image.asset(
                                'assets/Img/11.png',
                                height: 150,
                                width: 200,
                              )),
                        ),
                        Container(
                          child: Transform.translate(
                              offset: const Offset(35, 20),
                              child: Image.asset(
                                'assets/Img/12.png',
                                height: 130,
                                width: 130,
                              )),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0, -50),
                      child: Container(
                        child: Image.asset(
                          'assets/Img/logowelcome.png',
                          height: 180,
                          width: 180,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                height: 300,
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 130,
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
                                  duration: const Duration(milliseconds:100 ,),
                                  top: contenershaplogin,
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
                                    child: Icon(iconcount? Icons.email:Icons.password,color: Colors.white,),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            children: [
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  onTap: (){
                                    setState(() {
                                      contenershaplogin=0;
                                      iconcount=true;
                                    });
                                  },
                                  controller: emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Email Address',
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
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 270,
                                child: TextFormField(
                                  onChanged: (password) {
                                   setState(() {
                                     if(password.length>=8){singin=true;}
                                     else{singin=false;}
                                   });
                                  },
                                  onTap: (){
                                    setState(() {
                                      contenershaplogin=80;
                                      iconcount=false;
                                    });
                                  },
                                  controller: password,
                                  obscureText: ShowPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    labelStyle: const TextStyle(color: Colors.teal),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            ShowPassword = !ShowPassword;
                                          });
                                        },
                                        icon: Icon(
                                          ShowPassword
                                              ? CupertinoIcons.eye_fill
                                              : CupertinoIcons.eye_slash_fill,
                                          color: Colors.teal,
                                        )),
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
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                     Container(
                       child:singin? Container(
                         child: loginloding?ElevatedButton(
                           onPressed: () {
                             setState(() {
                               loginloding=false;
                               Timer(const Duration(seconds: 2), () {Auth.login(context: context);loginloding=true;singin=false;});
                             });
                           },
                           style: ButtonStyle(
                               backgroundColor:
                               MaterialStateProperty.all(Colors.teal.shade300),
                               fixedSize: MaterialStateProperty.all(const Size(100, 30))),
                           child: const Text('LogIn'),
                         ):const CircularProgressIndicator(),
                       ):ElevatedButton(onPressed: (){
                         showSnackBar(context: context, text: 'Enter Full Data', color1: Colors.red);
                       },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)), child: const Text('SingIn',style: TextStyle(color: Colors.white),),),
                     ),




                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingUP(Lat: 0.0,Long: 0.0,LocationAdd: false,Dis: '',City: 0,)));
                              },
                              child: const Text(
                                'انشىء حسابك الان',
                                style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),
                              )),
                          const Text(
                            'ليس لديك حساب؟',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
             /* const Text('OR You Can SingIn With Gmail & Phone'),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(55),
                    splashColor:  const Color.fromRGBO(0, 175, 162, 10),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const PhoneNumber()));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration:  const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
                      child: Lottie.asset('assets/lottie/phone.json'),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  InkWell(
                    borderRadius: BorderRadius.circular(55),
                    splashColor: const Color.fromRGBO(0, 175, 162, 10),
                    onTap: () async {
                      await GoogleProviderSignIn.googlelogin(context: context);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
                      child: Lottie.asset('assets/lottie/google.json'),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
