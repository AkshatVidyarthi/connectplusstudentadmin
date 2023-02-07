import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ADMIN APP'),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('ALL'),
                ),
                Tab(
                  child: Text('STUDENT'),
                ),
                Tab(
                  child: Text('ALUMNI'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('users').snapshots(),
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
                        final allUserDocs = data.docs;
                        return ListView(
                          children: allUserDocs.map((document) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 8.0,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Course: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("course")}"),

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
                                            Text('fullName: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("fullName")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('PassingYear: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text(
                                                "${document.get("passingYear")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('Category: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("type")}"),
                                          ],
                                        ),
                                        SizedBox(width :100,),
                                        IconButton(
                                            onPressed: () async{
                                             await document.reference.delete();
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
              StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('users').where("type",isEqualTo: "student").snapshots(),
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
                        final allUserDocs = data.docs;
                        return ListView(
                          children: allUserDocs.map((document) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 8.0,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Course: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("course")}"),

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
                                            Text('fullName: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("fullName")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('PassingYear: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text(
                                                "${document.get("passingYear")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('Category: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("type")}"),
                                          ],
                                        ),
                                        SizedBox(width :100,),
                                        IconButton(
                                            onPressed: () async{
                                              await document.reference.delete();
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
              StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('users').where("type",isEqualTo: "alumni").snapshots(),
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
                        final allUserDocs = data.docs;
                        return ListView(
                          children: allUserDocs.map((document) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 8.0,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Course: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("course")}"),

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
                                            Text('fullName: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("fullName")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('PassingYear: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text(
                                                "${document.get("passingYear")}"),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text('Category: ',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            Text("${document.get("type")}"),
                                          ],
                                        ),
                                        SizedBox(width :100,),
                                        IconButton(
                                            onPressed: () async{
                                              await document.reference.delete();
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
            ],
          ),
        ));
  }
}
