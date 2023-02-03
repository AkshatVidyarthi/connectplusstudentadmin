
import 'package:connectplusstudentadmin/ViewJobs.dart';
import 'package:connectplusstudentadmin/ViewUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//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
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewUsers();
            },));
          }, child: Text('VIEW USERS')),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewJobs();
            },));
          }, child: Text('VIEW JOBS')),
        ],
      ),
    );
  }
}
