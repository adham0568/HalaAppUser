import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/Pages/LogInPage/otpsecreen.dart';
import '../../models/snack.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}
final _PhoneNumber=TextEditingController();

class _PhoneNumberState extends State<PhoneNumber> {
/*===========================================================================================*/
  Country country = Country(
      phoneCode: '20',
      countryCode: 'EG',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Egypt',
      example: 'Egypt',
      displayName: 'Egypt',
      displayNameNoCountryCode: 'EG',
      e164Key: '');

/*===========================================================================================*/
  phone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${country.phoneCode}${_PhoneNumber.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showSnackBar(context: context, text: '$e', color1: Colors.red);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpsecreen(verificationId: verificationId,PhoneNumber1:'+${country.phoneCode}${_PhoneNumber.text.trim()}',)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    catch(e){
      showSnackBar(context: context, text: 'error', color1: Colors.red);
    }
  }

/*===========================================================================================*/

  @override
  Widget build(BuildContext context) {
    _PhoneNumber.selection=TextSelection.fromPosition(
      TextPosition(offset: _PhoneNumber.text.length)
    );
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
              const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.all(15),
                height: 300,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:400 ,
                      child: TextFormField(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          setState(() {
                            _PhoneNumber.text=value;
                          });
                        },
                        controller: _PhoneNumber,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          labelStyle: const TextStyle(color: Colors.teal),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(15),
                           child:InkWell(
                               onTap: () {
                                 showCountryPicker(context: context,
                                     countryListTheme: CountryListThemeData(
                                       bottomSheetHeight: 500,
                                       flagSize: 30,
                                         borderRadius: BorderRadius.circular(30),
                                         backgroundColor: Colors.black38,textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                                     ), onSelect: (value) {
                                   setState(() {
                                     country = value;
                                   });
                                 },);
                               },
                               child: Text('${country.flagEmoji} + ${country.phoneCode}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: _PhoneNumber.text.length>9?Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                            child: const Icon(Icons.done,color: Colors.white,),
                          ):null,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.teal.shade300),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Center(
                      child: ElevatedButton(onPressed: (){
                        phone();
                      },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal.shade300)), child: const Text('Send Code'),),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              const SizedBox(
                height: 250,
                width: 500,
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }
}


