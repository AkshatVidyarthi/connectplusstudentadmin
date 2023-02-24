import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobListScreen extends StatefulWidget {
  final DocumentReference<Object?> reference;
  const JobListScreen({Key? key, required this.reference}) : super(key: key);
  @override
  State<JobListScreen> createState() => _JobListScreenState();
}
class _JobListScreenState extends State<JobListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('VIEW JOBS'),
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        builder: (context, snapShot1) {
          if (snapShot1.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot1.hasError) {
            return Center(
              child: Text("${snapShot1.error}"),
            );
          }
          final document = snapShot1.data?.get("data");
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('COMPANY NAME:  ',
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Text("${document[index]["Companyname"]}"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('LOCATION: ',
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Text("${document[index]["Location"]}"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('EMAIL: ',
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Text("${document[index]["email"]}"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('JOB DESCRIPTION: ',
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Text("${document[index]["jobdescription"]}"),
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
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Text("${document[index]["jobtitle"]}"),
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
                            Text("${document[index]["maxexp"]}"),
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
                            Text("${document[index]["minexp"]}"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('ALLOW USER?',
                              style: GoogleFonts.cairo(
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),),
                            Switch(
                              value: document[index]["isVerified"],
                              onChanged: (value) {
                                snapShot1.data?.reference.set(
                                  {"data": FieldValue.arrayRemove(document)},
                                );

                                document[index]["isVerified"] = value;

                                snapShot1.data?.reference.set(
                                  {"data": FieldValue.arrayUnion(document)},
                                );

                                /*document[index].reference.set(
                                 {"isVerified": value},
                                 SetOptions(merge: true),
                               );*/
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
                                  fontSize: 16,fontWeight: FontWeight.bold
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  snapShot1.data?.reference.set(
                                    {"data": FieldValue.arrayRemove(document)},
                                  );
                                  document.removeAt(index);
                                  snapShot1.data?.reference.set(
                                    {"data": FieldValue.arrayUnion(document)},
                                  );
                                },
                                icon: Icon(Icons.delete)),
                            ]
                        ),
                            SizedBox(height: 8,),
                            document[index]["attachment"] != null ||
                                document[index]["attachment"].toString().toLowerCase() != "null"
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
                                        final url = document[index]["attachment"];
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
            itemCount: document.length,
          );
        },
        stream: widget.reference.snapshots(),
      ),
    );
  }
}
