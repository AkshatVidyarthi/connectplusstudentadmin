import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  bool isVerified = false;
  List<QueryDocumentSnapshot<Object?>> jobList = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text('View Users'),
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
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: JobsSearchDelegate(jobList));
                  },
                  icon: const Icon(Icons.search_rounded)),
            ],
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
                  }
                  else
                  {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else {
                      final data = snapshot.data;
                      if (data != null) {
                        final allUserDocs = data.docs;
                        return ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: allUserDocs.map((document) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          elevation: 8.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('COURSE: ',
                                                      style: GoogleFonts.cairo(
                                                          fontSize: 16,fontWeight: FontWeight.bold
                                                      ),),
                                                    Text("${document.get("course")}"),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Text('FULLNAME:  ',
                                                      style: GoogleFonts.cairo(
                                                          fontSize: 16,fontWeight: FontWeight.bold
                                                      ),),
                                                    Text("${document.get("fullName")}"),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text('PASSING YEAR:  ',
                                                      style: GoogleFonts.cairo(
                                                          fontSize: 16,fontWeight: FontWeight.bold
                                                      ),),
                                                    Text(
                                                        "${document.get("passingYear")}"),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text('CATEGORY: ',
                                                      style: GoogleFonts.cairo(
                                                          fontSize: 16,fontWeight: FontWeight.bold
                                                      ),),
                                                    Text("${document.get("type")}"),
                                                  ],
                                                ),
                                               SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Text('ALLOW USER?',style: TextStyle(
                                                      fontWeight: FontWeight.bold
                                                    )),
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
                                                ),
                                                Row(
                                                  children: [
                                                    Text('DELETE USER?',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(context: context,
                                                            builder: (context){
                                                              return Container(
                                                                child: AlertDialog(
                                                                  title: Text("Do you really want to delete this post ?"),
                                                                  actions: [
                                                                    TextButton(onPressed: ()async {
                                                                      await document.reference.delete();

                                                                      Navigator.pop(context);
                                                                    },
                                                                      child: Text("YES"),),
                                                                    TextButton(onPressed: (){
                                                                      Navigator.pop(context);
                                                                    },
                                                                      child: Text("NO"),),

                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: allUserDocs.map((document) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        elevation: 8.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(

                                                children: [
                                                  Text('COURSE: ',
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 16,fontWeight: FontWeight.bold
                                                    ),),
                                                  Text("${document.get("course")}"),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('FULL NAME: ',
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 16,fontWeight: FontWeight.bold
                                                    ),),
                                                  Text("${document.get("fullName")}"),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text('PASSING YEAR: ',
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 16,fontWeight: FontWeight.bold
                                                    ),),
                                                  Text(
                                                      "${document.get("passingYear")}"),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Text('CATEGORY: ',
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 16,fontWeight: FontWeight.bold
                                                    ),),
                                                  Text("${document.get("type")}"),
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text('ALLOW USER',style: TextStyle(fontWeight: FontWeight.bold),),
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
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text("DELETE: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(context: context,
                                                          builder: (context){
                                                            return Container(
                                                              child: AlertDialog(
                                                                title: Text("Do you really want to delete this user ?"),
                                                                actions: [
                                                                  TextButton(onPressed: ()async {
                                                                    await document.reference.delete();

                                                                    Navigator.pop(context);
                                                                  },
                                                                    child: Text("YES"),),
                                                                  TextButton(onPressed: (){
                                                                    Navigator.pop(context);
                                                                  },
                                                                    child: Text("NO"),),

                                                                ],
                                                              ),
                                                            );
                                                          }
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: allUserDocs.map((document) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 8.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('COURSE: ',
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 16,fontWeight: FontWeight.bold
                                                  ),),
                                                Text("${document.get("course")}"),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text('FULL NAME: ',
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 16,fontWeight: FontWeight.bold
                                                  ),),
                                                Text("${document.get("fullName")}"),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text('PASSING YEAR: ',
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 16,fontWeight: FontWeight.bold
                                                  ),),
                                                Text(
                                                    "${document.get("passingYear")}"),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text('Category: ',
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 16,fontWeight: FontWeight.bold
                                                  ),),
                                                Text("${document.get("type")}"),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text('ALLOW USER',style: TextStyle(fontWeight: FontWeight.bold),),
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
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Text('DELETE',style: TextStyle(fontWeight: FontWeight.bold),),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(context: context,
                                                        builder: (context){
                                                          return Container(
                                                            child: AlertDialog(
                                                              title: Text("Do you really want to delete this user ?"),
                                                              actions: [
                                                                TextButton(onPressed: ()async {
                                                                  await document.reference.delete();

                                                                  Navigator.pop(context);
                                                                },
                                                                  child: Text("YES"),),
                                                                TextButton(onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                  child: Text("NO"),),

                                                              ],
                                                            ),
                                                          );
                                                        }
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
class JobsSearchDelegate extends SearchDelegate {
  final List<QueryDocumentSnapshot<Object?>> jobList;

  JobsSearchDelegate(this.jobList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CloseButton(
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = jobList
        .where((element) =>
        element
            .get("fullName")
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()
        )
    ).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,index)
    {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('COURSE: ',
                            style: GoogleFonts.cairo(
                                fontSize: 16,fontWeight: FontWeight.bold
                            ),),
                          Text("${filteredList.get("course")}"),
                          SizedBox(height: 10,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('FULL NAME: ',
                            style: GoogleFonts.cairo(
                                fontSize: 16,fontWeight: FontWeight.bold
                            ),),
                          Text("${document.get("fullName")}"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('PASSING YEAR: ',
                            style: GoogleFonts.cairo(
                                fontSize: 16,fontWeight: FontWeight.bold
                            ),),
                          Text(
                              "${document.get("passingYear")}"),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Category: ',
                            style: GoogleFonts.cairo(
                                fontSize: 16,fontWeight: FontWeight.bold
                            ),),
                          Text("${document.get("type")}"),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('ALLOW USER',style: TextStyle(fontWeight: FontWeight.bold),),
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
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('DELETE',style: TextStyle(fontWeight: FontWeight.bold),),
                          IconButton(
                            onPressed: () {
                              showDialog(context: context,
                                  builder: (context){
                                    return Container(
                                      child: AlertDialog(
                                        title: Text("Do you really want to delete this user ?"),
                                        actions: [
                                          TextButton(onPressed: ()async {
                                            await document.reference.delete();

                                            Navigator.pop(context);
                                          },
                                            child: Text("YES"),),
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                            child: Text("NO"),),

                                        ],
                                      ),
                                    );
                                  }
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

