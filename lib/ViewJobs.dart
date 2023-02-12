import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        stream: FirebaseFirestore.instance.collection('jobposted').snapshots(),
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
                    final userId = ViewJobs[index].id;
                    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      builder: (context, snapShot1) {
                        if(snapShot1.connectionState==ConnectionState.waiting)
                          {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        else{
                          if(snapShot1.hasError)
                            {
                              return Center(
                                child: Text("${snapshot.error}"),
                              );
                            }
                        }
                        final document = snapShot1.data?.docs.first;
                        ViewJobs[index]
                            .reference
                            .get()
                            .then((value) => print(value.get("data")));
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return JobListScreen(reference:  ViewJobs[index].reference,);
                              }),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('FULLNAME:  ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document?.get("fullName")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('COURSE:  ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document?.get("course")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('PASSING YEAR:  ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document?.get("passingYear")}"),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('ID:  ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document?.get("id")}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .where(userId)
                          .get(),
                    );
                  },
                  itemCount: ViewJobs.length,
                );
              }
              else {
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
