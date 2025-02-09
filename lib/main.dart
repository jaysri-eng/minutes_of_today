import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minutes_of_today/database/databaseHelper.dart';
import 'package:minutes_of_today/screens/homepage.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() async{
  DatabaseHelper databaseHelper = DatabaseHelper();
  WidgetsFlutterBinding.ensureInitialized();
  String userId = await databaseHelper.signInAnonymously();
  print('Signed in with user ID: $userId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minutes of Today',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.black,
        nextScreen: const MyHomePage(),
        splashScreenBody: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/sands-of-time.png",height: 100,width: 80,),
              Text("MoT - Minutes of Today",style: GoogleFonts.montserrat(
                color: Colors.white,
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
