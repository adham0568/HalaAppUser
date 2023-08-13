import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../homepage.dart';

class Otpsecreen extends StatefulWidget {
   const Otpsecreen({super.key, required this.verificationId,required this.PhoneNumber1});
   final String verificationId;
   final String PhoneNumber1;

  @override
  State<Otpsecreen> createState() => _OtpsecreenState();
}

class _OtpsecreenState extends State<Otpsecreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final OTBcode=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
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
            const SizedBox(height: 15,),
            Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Code Sent To',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                Text(widget.PhoneNumber1.substring(2,13),style: const TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),

              ],
            )),
            const SizedBox(height: 15,),
            Container(
              child: Pinput(
                controller:OTBcode ,
                length: 6,
              showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal),
                  ),
                  textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId, smsCode: OTBcode.text);
                await auth.signInWithCredential(credential);
                if (auth.currentUser != null) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => const HomePage()),(route) => false,);
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.teal.shade300)),
              child: const Text(
                'Verify',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
