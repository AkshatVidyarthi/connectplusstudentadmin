import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ViewFeedbacks extends StatefulWidget {
  const ViewFeedbacks({Key? key}) : super(key: key);

  @override
  State<ViewFeedbacks> createState() => _ViewFeedbacksState();
}
class _ViewFeedbacksState extends State<ViewFeedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: Text('VIEW FEEDBACKS'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('feedback').snapshots(),
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
                final ViewFeedback = data.docs;
                return ListView(
                  children: ViewFeedback.map((document) {
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
                                      Text('FEEDBACK: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("feedback")}"),

                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Text('TIME DURATION: ',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                      Text("${document.get("timestamp")}"),
                                    ],
                                  ),
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
