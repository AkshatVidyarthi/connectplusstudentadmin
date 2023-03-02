import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'jobs_list_screen.dart';

class ViewJobs extends StatefulWidget {
  const ViewJobs({Key? key}) : super(key: key);

  @override
  State<ViewJobs> createState() => _ViewJobsState();
}
class _ViewJobsState extends State<ViewJobs> {
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIEW JOBS'),
        elevation: 8.0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('PostedJobs')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              final data = snapshot.data;
              if (data != null) {
                final ViewJobs = data.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final document = ViewJobs[index];
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),),
                        elevation: 8.0,
                        child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                          children: [
                            Row(
                              children: [
                                Text('COMPANY NAME:  ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),),
                                Text("${document.get("Companyname")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('LOCATION: ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("Location")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('EMAIL: ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("email")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('JOB DESCRIPTION: ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("jobdescription")}"),
                              ],
                            ),
                            //sodpsl
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('JOB TITLE:  ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("jobtitle")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('MAXIMUM EXPERIENCE:  ',
                                  style: GoogleFonts.cairo(
                                      fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                Text("${document.get("maxexp")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('MINIMUM EXPERIENCE:  ',
                                  style: GoogleFonts.cairo(
                                      fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                Text("${document.get("minexp")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('QUALIFICATION:  ',
                                  style: GoogleFonts.cairo(
                                      fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                Text("${document.get("qualification")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('PACKAGE:  ',
                                  style: GoogleFonts.cairo(
                                      fontSize: 16,fontWeight: FontWeight.bold
                                  ),),
                                Text("${document.get("selectedsalary")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Text('ALLOW USER?',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Switch(
                                  value: document.get("isVerified"),
                                  onChanged: (value) {
                                    document.reference.set({
                                      "isVerified":value,
                                    },SetOptions(merge: true));

                                  },
                                  activeTrackColor: Colors.deepPurpleAccent,
                                  activeColor: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'DELETE USER?',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await document.reference.delete();

                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                            SizedBox(height: 8,),
                            document.get("attachment") != null ||
                                document.get("attachment").toString().toLowerCase() != "null"
                                ? Row(
                              children: [
                                Text('DOWNLOAD JOB DESCRIPTION',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                SizedBox(width: 10,),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: IconButton(
                                      onPressed: () async {
                                        final url = document.get("attachment");
                                        if (await canLaunchUrlString(url)) {
                                          launchUrlString(
                                            url,
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.download,color: Colors.black,
                                        size: 24,)),
                                ),
                              ],
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      ),
                    );
                  },
                  itemCount: ViewJobs.length,
                );
              } else {
                return const Center(
                  child: Text("Data not found"),
                );
              }
            }
          }
        },
      ),
    );
  }
}
