import 'package:flutter/material.dart';
import 'package:halaapp/Pages/AccountPages/AccountPage.dart';
import 'package:halaapp/Pages/AccountPages/FireBaseStatment.dart';

class EditData extends StatefulWidget {
  String Name;
  String Email;
  String Phone;
  EditData({Key? key,required this.Name,required this.Phone,required this.Email}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}
final Name=TextEditingController();
final Email=TextEditingController();
final Phone_Number=TextEditingController();

class _EditDataState extends State<EditData> {
@override
  void initState() {
    Name.text=widget.Name;
    Email.text=widget.Email;
    Phone_Number.text=widget.Phone;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FireBaseServces EditData=FireBaseServces();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
      body:Container(
        margin: const EdgeInsets.only(top: 70,bottom: 20,left: 20,right: 20),
        child: Center(
          child: Column(
            children: [
              Text('بياناتك الحالية',style: TextStyle(fontSize: w/10,fontWeight: FontWeight.bold,color: Colors.black54),),
              SizedBox(height: h/20,),
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: Name,
                  onTap: (){},
                  decoration: InputDecoration(
                    labelText: 'الاسم',
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
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: Email,
                  decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
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
              Container(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: Phone_Number,
                  onTap: (){},
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
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
              SizedBox(height: h/15,),
              InkWell(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountPage(),));
                  await EditData.DataUser(Name: Name.text, Email: Email.text, Phone: Phone_Number.text, context: context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    gradient:const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.cyan,
                        Colors.teal,
                      ]
                    )
                  ),
                  width: w*0.3,
                  height: h/20,
                  child: const Center(child: Text('تحديث البيانات',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
