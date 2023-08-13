import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:halaapp/Pages/AccountPages/AccountPage.dart';
import 'package:halaapp/Pages/AccountPages/FireBaseStatment.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../models/HIGHT.dart';
import '../../models/snack.dart';
import '../../provider/DataUser.dart';

/// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiYWRoYW0wNTY4IiwiYSI6ImNsanpuM3I3ODBrYXkzaG56Ymdhc2Z1MDMifQ.q0SCdN6iwR17f5JrUjL_ew';

class EditLocation extends StatefulWidget {
  bool WhichPage;//frome sing up is false
  EditLocation({required this.WhichPage,super.key});

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final LocatianDetales=TextEditingController();
  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  int? selectedTextIndex;
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
/*
//احداثيات طوباس للشرط الذي تم تعطيله في الاسفل
  double Positionlat1=  32.337748;
  double Positionlat2= 32.342748;
  double Positionlat3=  32.276990;
  double Positionlat4=  32.284801;
*/
  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  @override
  void initState() {
    widget.WhichPage?getCurrentLocation():null;
    super.initState();
  }
  FireBaseServces EditLocation=FireBaseServces();
  @override
  Widget build(BuildContext context) {
    final DataUser = Provider.of<Userdata>(context).getUser;
    return widget.WhichPage? Scaffold(
      body: myPosition == null
          ? Container(color: Colors.white,height: double.infinity,width: double.infinity,
          child: Center(child: Container(height: 100,width: 100,color: Colors.white,child: const CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.green,))))
          : Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: myPosition, minZoom: 18, maxZoom: 18, zoom: 18,),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'adham0568/clk87oepj00l001pfbpumgu7y'
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: myPosition!,
                    builder: (context) {
                      return Container(
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: SizedBox(
              width: 270,
              height: 120,
              child: TextField(
                maxLines: 7,
                controller: LocatianDetales,
                decoration: InputDecoration(
                  hintText: 'إضافة علامة مميزة \n مثل بجانب مسجد الفرقان \n او لون المبنى \n او اي علامة مميزة لمنزلك',
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
          ),
          Positioned(
            top: 500,
            left: 50,
            right: 50,
            child: Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(56, 95, 172, 1),
                        Color.fromRGBO(1, 183, 168, 1)
                      ]),
                  borderRadius: BorderRadius.circular(15)
              ),
              width: SizeFix().wight(context: context)/1.3,
              child: DropdownButtonFormField<int>(
                focusColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                dropdownColor: Colors.teal,
                style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                icon: const Icon(CupertinoIcons.location_fill,color: Colors.white,),
                value: selectedTextIndex,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedTextIndex = newValue;
                    print(selectedTextIndex);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'اختر المدينة',
                  labelStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                items: City.asMap().entries.map<DropdownMenuItem<int>>(
                      (MapEntry<int, String> entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key + 1,
                      child: Text(entry.value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              left: 50,
              right: 50,
              child: InkWell(
                onTap: () async {
                  if(LocatianDetales.text==''){ showSnackBar(context: context, text: 'الرجاء كتابة علامة مميزة او عنوان', color1: Colors.red);}
                  else if(selectedTextIndex! ==null){ showSnackBar(context: context, text: 'الرجاء تحديد المدينة', color1: Colors.red);}
                  else{
                  await EditLocation.EditLocation(City: selectedTextIndex!, Dis: LocatianDetales.text, Lat: myPosition!.latitude, Long: myPosition!.longitude, context: context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountPage(),));}
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(56, 95, 172, 1),
                        Color.fromRGBO(1, 183, 168, 1)
                      ])),
                  height: 60,
                  child: const Center(child: Text('التالي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
                ),
              )
          )
        ],
      ),
    )
        :
    Container(color: Colors.red,
      child: FlutterMap(
        options: MapOptions(
            center: LatLng(DataUser!.Lat, DataUser.Long), minZoom: 17, maxZoom: 18, zoom: 18),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'adham0568/clk87oepj00l001pfbpumgu7y'
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point:LatLng(DataUser.Lat, DataUser.Long),
                builder: (context) {
                  return Container(
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),);
  }
}
