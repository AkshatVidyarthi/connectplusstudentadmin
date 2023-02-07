import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobListScreen extends StatelessWidget {
  final DocumentReference<Object?> reference;
  const JobListScreen({Key? key, required this.reference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        builder: (context, snapShot1) {
          final document = snapShot1.data?.get("data");
          return ListView.builder(
            itemBuilder: (context, index) {
             return Column(
               children: [
                 Text("${document[index]["Companyname"]}"),
                 Text("${document[index]["Location"]}"),
                 Text("${document[index]["email"]}"),
                 Text("${document[index]["jobdescription"]}"),
                 Text("${document[index]["jobtitle"]}"),
                 Text("${document[index]["maxexp"]}"),
                 Text("${document[index]["minexp"]}"),
               ],
             );
            },
            itemCount: document.length,
          );
        },
        future: reference.get(),
      ),
    );
  }
}
