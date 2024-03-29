import 'package:connectplusstudentadmin/LoginScreen.dart';
import 'package:connectplusstudentadmin/ViewFeedbacks.dart';
import 'package:connectplusstudentadmin/ViewInternships.dart';
import 'package:connectplusstudentadmin/ViewJobs.dart';
import 'package:connectplusstudentadmin/ViewPayments.dart';
import 'package:connectplusstudentadmin/ViewUsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
//dfghjkl;'
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//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
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Are You Sure You Want to Logout"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('LOGOUT'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  },));
                }
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: Text('Connect+ Student Dashboard',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: Drawer(
        elevation: 8.0,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(child: Text('Connect+ Student',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Image.asset('assets/connect-student-logo-removebg-preview.png',height: 160,width: 160),
            Text('AKSHAT VIDYARTHI',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 6,),
            Text('ADMIN PANEL',style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.view_comfy_sharp,size: 30,color: Colors.black),
              title: Text('VIEW USERS',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewUsers();
                },));
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.view_comfy_sharp,size: 30,color: Colors.black),
              title: Text('VIEW JOBS',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewJobs();
                },));
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.view_comfy_sharp,size: 30,color: Colors.black),
              title: Text('VIEW INTERNSHIPS',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewInternships();
                },));
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.view_comfy_sharp,size: 30,color: Colors.black),
              title: Text('VIEW FEEDBACKS',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewFeedbacks();
                },));
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.view_comfy_sharp,size: 30,color: Colors.black),
              title: Text('VIEW PAYMENTS',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewPayments();
                },));
              },
            ),
            ListTile(
              style: ListTileStyle.drawer,
              leading: Icon(Icons.logout,size: 30,color: Colors.black),
              title: Text('LOGOUT',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple)),
              onTap: ()
                {
                  showAlertDialog();
                }

            ),


          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Center(child: Image.asset('assets/connect-student-logo-removebg-preview.png',width: 240)),
          Text('Welcome Back Admin!',style: GoogleFonts.arsenal(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceAround ,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1C4E9),width: 1.0),
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListTile(
                              title: Text('VIEW INTERNSHIPS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold)),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ViewInternships();
                                },));
                              },
                              trailing: Icon(Icons.view_comfy_sharp,color: Colors.black,size: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1C4E9),width: 1.0),
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListTile(
                              title: Text('VIEW JOBS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold)),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ViewJobs();
                                },));
                              },
                              trailing: Icon(Icons.view_comfy_sharp,color: Colors.black,size: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1C4E9),width: 1.0),
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListTile(
                              title: Text('VIEW USERS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold)),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ViewUsers();
                                },));
                              },
                              trailing: Icon(Icons.view_comfy_sharp,color: Colors.black,size: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1C4E9),width: 1.0),
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListTile(
                              title: Text('VIEW FEEDBACKS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold)),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ViewFeedbacks();
                                },));
                              },
                              trailing: Icon(Icons.view_comfy_sharp,color: Colors.black,size: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 4.0,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1C4E9),width: 1.0),
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          height: 150,
                          width: 250,
                          child: Center(
                            child: ListTile(
                              title: Text('VIEW PAYMENTS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold)),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ViewPayments();
                                },));
                              },
                              trailing: Icon(Icons.view_comfy_sharp,color: Colors.black,size: 32),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
          ],
      ),
    );
  }
}
