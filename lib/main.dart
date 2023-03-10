
import 'package:connectplusstudentadmin/LoginScreen.dart';
import 'package:connectplusstudentadmin/MainScreen.dart';
import 'package:connectplusstudentadmin/ViewInternships.dart';
import 'package:connectplusstudentadmin/ViewJobs.dart';
import 'package:connectplusstudentadmin/ViewUsers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      home: HomeScreen(),
    );
  }
}





