import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/snack.dart';
import 'package:halaapp/provider/CartProvider.dart';
import 'package:halaapp/provider/DataUser.dart';
import 'package:halaapp/provider/GoogelProvider.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';
import 'Pages/LogInPage/SinInPage.dart';
import 'Pages/homepage.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context){return GoogleSignInProvider();}),
        ChangeNotifierProvider(create: (context){return CartProvider();}),
        ChangeNotifierProvider(create: (context){return total();}),
        ChangeNotifierProvider(create: (context){return Userdata();})
      ],
      child: MaterialApp(
        theme:ThemeData(colorSchemeSeed: Colors.white),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator(color: Colors.white,));}
              else if (snapshot.hasError) {return showSnackBar(context: context, text: 'Error 404', color1: Colors.red);}
              else if (snapshot.hasData) {return const HomePage();}
              else { return const LogIn();}
            },
          )),
    );

  }
}
