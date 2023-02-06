
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
                  children: ViewJobs.map((document)
                  {
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
                                    mainAxisAlignment:MainAxisAlignment.start,
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
                                      Text('MAXIMUM EXPERIENCE(IN YEARS): ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("maxexp")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('MINIMUM EXPERIENCE(IN YEARS): ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("minexp")}"),
                                    ],
                                  ),
                                 SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('DELETE JOB: ',style: TextStyle(fontWeight: FontWeight.bold)),
                                      IconButton(
                                          onPressed: () {
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('CONFIRM JOB: ',style: TextStyle(fontWeight: FontWeight.bold)),
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
