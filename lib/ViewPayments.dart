import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPayments extends StatefulWidget {
  const ViewPayments({Key? key}) : super(key: key);

  @override
  State<ViewPayments> createState() => _ViewPaymentsState();
}

class _ViewPaymentsState extends State<ViewPayments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Payments'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
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
                final ViewPayment = data.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final document = ViewPayment[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 8.0,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'STATUS:  ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("status")}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'AMOUNT IN RUPEES: ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("amount")}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'MESSAGE: ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("message")}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'NAME: ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("name")}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'MAIL: ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("mail")}"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*Row(
                                children: [
                                  Text(
                                    'MOBILE NUMBER: ',
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text("${document.get("number")}"),
                                ],
                              ),
                              FutureBuilder(

                                builder: (context, snapshot) {
                                 if(snapshot.connectionState==ConnectionState.waiting)
                                   {
                                     return Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   }
                                 if (snapshot.hasError) {
                                   return Center(
                                     child: Text("${snapshot.error}"),
                                   );
                                 }
                                  return Row(
                                    children: [
                                      Text('COURSE: ',
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),),
                                  Text("${snapshot.data?.get("course")}"
                                  ) ],
                                  );

                                },
                                future: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(document.get("userId"))
                                    .get(),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: ViewPayment.length,
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
