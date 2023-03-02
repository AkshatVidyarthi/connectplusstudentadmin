import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectplusstudentadmin/InternshipListScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'jobs_list_screen.dart';

class ViewInternships extends StatefulWidget {
  const ViewInternships({Key? key}) : super(key: key);

  @override
  State<ViewInternships> createState() => _ViewInternshipsState();
}

class _ViewInternshipsState extends State<ViewInternships> {
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIEW INTERNSHIPS'),
        elevation: 8.0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('PostedInternships')
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
                final ViewInterns = data.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final document = ViewInterns[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),),
                        elevation: 8.0,
                        child:Padding(
                          padding: EdgeInsets.all(16),
                        child:
                        Column(
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

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('DURATION OF THE INTERNSHIP: ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("duration")}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('STIPEND OFFERED: ',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),),
                                Text("${document.get("stipend")}"),
                              ],
                            ),
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
                                      /*snapShot2.data?.reference.set(
                                        {"data": FieldValue.arrayRemove(document)},
                                      );
                                      document.removeAt(index);
                                      snapShot2.data?.reference.set(
                                        {"data": FieldValue.arrayUnion(document)},
                                      );*/
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                            SizedBox(height: 8,),
                            document.get("attachment") != null
                                ? Row(
                              children: [
                                Text('DOWNLOAD INTERNSHIP DESCRIPTION',
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
                  itemCount: ViewInterns.length,
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
