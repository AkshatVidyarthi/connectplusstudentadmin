import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InternshipListScreen extends StatelessWidget {
  final DocumentReference<Object?> reference;

  const InternshipListScreen({Key? key, required this.reference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('VIEW INTERNSHIPS'),
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        builder: (context, snapShot2) {
          if (snapShot2.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShot2.hasError) {
            return Center(
              child: Text("${snapShot2.error}"),
            );
          }
          final document = snapShot2.data?.get("data");
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('COMPANY NAME:  ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${document[index]["Companyname"]}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('LOCATION',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${document[index]["Location"]}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('EMAIL: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${document[index]["email"]}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('JOB DESCRIPTION',
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${document[index]["jobtitle"]}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('ALLOW USER?',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Switch(
                            value: document[index]["isVerified"],
                            onChanged: (value) {
                              snapShot2.data?.reference.set(
                                {"data": FieldValue.arrayRemove(document)},
                              );

                              document[index]["isVerified"] = value;

                              snapShot2.data?.reference.set(
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                snapShot2.data?.reference.set(
                                  {"data": FieldValue.arrayRemove(document)},
                                );
                                document.removeAt(index);
                                snapShot2.data?.reference.set(
                                  {"data": FieldValue.arrayUnion(document)},
                                );
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: document.length,
          );
        },
        stream: reference.snapshots(),
      ),
    );
  }
}
