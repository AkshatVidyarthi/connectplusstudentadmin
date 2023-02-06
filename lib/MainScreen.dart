import 'package:connectplusstudentadmin/ViewInternships.dart';
import 'package:connectplusstudentadmin/ViewJobs.dart';
import 'package:connectplusstudentadmin/ViewUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        title: Text('Connect+ Student Dashboard',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold)),

        backgroundColor: Colors.deepPurpleAccent,
      ),
      drawer: Drawer(
        elevation: 8.0,
        backgroundColor: Colors.deepPurpleAccent,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(child: Text('Connect+ Student',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Image.asset('connect-student-logo-removebg-preview.png',height: 160,width: 160),
            Text('AKSHAT VIDYARTHI',style: GoogleFonts.arsenal(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 6,),
            Text('ADMIN PANEL',style: TextStyle(fontWeight: FontWeight.bold)),

          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Center(child: Image.asset('connect-student-logo-removebg-preview.png',width: 240)),
          Text('Welcome Back Admin!',style: GoogleFonts.arsenal(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround ,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 150,
                    width: 250,
                    child: Center(
                      child: ListTile(
                        title: Text('VIEW USERS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black)),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ViewUsers();
                          },));
                        },
                        trailing: Icon(Icons.view_comfy_sharp,size: 32,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 150,
                    width: 250,
                    child: Center(
                      child: ListTile(
                        title: Text('VIEW FEEDBACKS',style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black)),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ViewUsers();
                          },));
                        },
                        trailing: Icon(Icons.view_comfy_sharp,size: 32,color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

          ],
      ),
    );
  }
}
