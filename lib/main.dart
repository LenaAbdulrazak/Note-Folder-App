import 'dart:io';

import 'package:androidfirebasepractice/HomePage.dart';
import 'package:androidfirebasepractice/Sign_in.dart';
import 'package:androidfirebasepractice/Sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyB90INfgVY0dEKIoyV_Me_F56awszoBw0I",
              appId: "1:592245969296:android:9406f72b567e65e994e315",
              messagingSenderId: "592245969296",
              projectId: "flutterfirbase-f6191"
              ))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "signup": (context) => const Sign_up(),
        "signin": (context) => const Sign_in(),
        "homePage": (context) =>  const Home_page(),
        
      },
      
      theme: ThemeData(
      textTheme: const TextTheme(
              titleLarge: TextStyle(fontFamily: 'Patrick Hand',
                    fontWeight: FontWeight.bold),
                
                    bodySmall: TextStyle(fontFamily: 'Patrick Hand',fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    fontFamily: "Patrick Hand",
                    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade100,
          titleTextStyle:  TextStyle(color:Colors.pink.shade400,fontSize: 25,fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.pink.shade400)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser!=null )? const Home_page():const Sign_in(),
          //  const Sign_in(),
        
    );
  }
}
