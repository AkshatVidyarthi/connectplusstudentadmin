import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectplusstudentadmin/InternshipListScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            .collection('InternshipsPosted')
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
                    final userId = ViewInterns[index].id;
                    print(userId);
                    return FutureBuilder<
                        DocumentSnapshot<Map<String, dynamic>>>(
                      builder: (context, snapShot2) {
                        if (snapShot2.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapShot2.hasError) {
                            return Center(
                              child: Text("${snapshot.error}"),
                            );
                          }
                        }
                        final document = snapShot2.data;
                        return (snapShot2.data?.exists ?? false)
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return InternshipListScreen(
                                        reference: ViewInterns[index].reference,
                                      );
                                    }),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('FULLNAME:  ',
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 16,fontWeight: FontWeight.bold
                                                  ),),
                                              Text(
                                                  "${document?.get("fullName")}"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('COURSE:  ',
                                                style: GoogleFonts.cairo(
                                                    fontSize: 16,fontWeight: FontWeight.bold
                                                ),),
                                              Text("${document?.get("course")}"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('PASSING YEAR:  ',
                                                style: GoogleFonts.cairo(
                                                    fontSize: 16,fontWeight: FontWeight.bold
                                                ),),
                                              Text(
                                                  "${document?.get("passingYear")}"),
                                            ],
                                          ),
                                          /*SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text('ID:  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("${document?.get("id")}"),
                                            ],
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox();
                      },
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(userId)
                          .get(),
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
