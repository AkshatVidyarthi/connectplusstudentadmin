
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewJobs extends StatefulWidget {
  const ViewJobs({Key? key}) : super(key: key);

  @override
  State<ViewJobs> createState() => _ViewJobsState();
}

class _ViewJobsState extends State<ViewJobs> {
  bool isVerified=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIEW JOBS'),
        elevation: 8.0,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('jobposted').snapshots(),
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
                final ViewJobs = data.docs;
                return ListView(
                  children: ViewJobs.map((document) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5.0,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Company Name:',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("Companyname")}"),
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
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Location',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("Location")}"),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text('email',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text(
                                        "${document.get("email")}"),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text('Job Description',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("jobdescription")}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Job Title',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("jobtitle")}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('MAX experience',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("maxexp")}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Minimum Experience',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                    Text("${document.get("minexp")}"),
                                  ],
                                ),
                                SizedBox(width :100,),
                                IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
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
