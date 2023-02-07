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
                  itemBuilder: (conetext, index) {
                    final userId = ViewJobs[index].id;
                    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      builder: (context, snapShot1) {
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
                          child: Card(
                            child: Column(
                              children: [
                                Text("${document?.get("fullName")}"),
                                Text("${document?.get("course")}"),
                                Text("${document?.get("passingYear")}"),
                                Text("${document?.get("id")}"),
                              ],
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
