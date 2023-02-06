import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ViewInternships extends StatefulWidget {
  const ViewInternships({Key? key}) : super(key: key);

  @override
  State<ViewInternships> createState() => _ViewInternshipsState();
}
class _ViewInternshipsState extends State<ViewInternships> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: Text('VIEW INTERNSHIPS'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('InternshipsPosted').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
                return ListView(
                  children: ViewInterns.map((document) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('COMPANY NAME: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("Companyname")}"),

                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('LOCATION: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("Location")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('EMAIL: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text(
                                          "${document.get("email")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('JOB DESCRIPTION: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("jobdescription")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('JOB TITLE: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("jobtitle")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('DELETE INTERNSHIP: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                      IconButton(
                                          onPressed: () {
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('CONFIRM INTERNSHIP: ',style: TextStyle(fontWeight: FontWeight.bold),),
                                      Switch(
                                        value: document.get("isVerified"),
                                        onChanged: (value) {
                                          document.reference.set(
                                            {"isVerified": value},
                                            SetOptions(merge: true),
                                          );
                                        },
                                        activeTrackColor:
                                        Colors.deepPurpleAccent,
                                        activeColor: Colors.black,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
              else {
                return Center(
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
