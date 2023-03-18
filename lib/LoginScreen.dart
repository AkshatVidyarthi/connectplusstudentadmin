import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? Email;
  String? Password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     body: SafeArea(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(height: 50,),
               Text('Connect+ Student',style: GoogleFonts.arsenal(
                 fontWeight: FontWeight.bold,fontSize: 32,
               ),),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('LOGIN AS ADMIN',style: GoogleFonts.arsenal(
                 fontWeight: FontWeight.bold,
                 fontSize: 24,
               ),)
             ],
           ),
           Card(
             color: Colors.white70,
             elevation: 8.0,
             child: Container(
               height: 600,
               width: 500,
               child: Column(
                 children: [
                   Image.asset('connect-student-logo-removebg-preview.png',height: 200),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: TextFormField(
                              onSaved: (value) {
                                Email = value;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Email',
                                hintText: 'Enter Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: TextFormField(
                              obscureText: true,
                              onSaved: (value) {
                                Password = value;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Password";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                                  onPressed: () async {
                                    formkey.currentState?.save();
                                    if (formkey.currentState?.validate() ?? false) {
                                      final data = await FirebaseDatabase.instance
                                          .ref("data")
                                          .child("admin")
                                          .child("credentials")
                                          .get();
                                      print(data.child("email").value);
                                      print(data.child("password").value);
                                      if (Email?.trim() == data.child("email").value.toString() &&
                                          Password?.trim() == data.child("password").value.toString()) {
                                        if (!mounted) return;
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return const HomeScreen();
                                          },
                                        ));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text("Email or Password is invailid")));
                                      }
                                    }
                                  },
                                  child: Text('LOGIN',style: GoogleFonts.arsenal(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                 ],
               ),
             ),
           )
         ],
       ),
     ),

    );
  }
}
