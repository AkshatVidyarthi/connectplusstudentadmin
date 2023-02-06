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
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('LOGIN',
            style: GoogleFonts.arsenal(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Image.network(
                      'https://npgc.in/assets/images/CollegeLogo.png?Valu=92cb77e4-67fd-4ede-aed4-59024c24a292')),
              Center(
                  child: Text(
                'PRESENTS',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Connect+ Student',
                style: GoogleFonts.arsenal(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Image.asset('connect-student-logo-removebg-preview.png',
                    width: 240),
              ),
              /*Padding(
                padding: EdgeInsets.all(40),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  40
                    ),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6,
                          errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15,
                          errorText:
                          "Password should not be greater than 15 characters")
                    ]),
                  //validatePassword,        //Function to check validation
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    },));
                  }
                  else {
                    print("not validated");
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
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
              ElevatedButton(
                  onPressed: () async {
                    formkey.currentState?.save();
                    if (formkey.currentState?.validate() ?? false) {
                      final data = await FirebaseDatabase.instance
                          .ref("data")
                          .child("admin")
                          .child("credentials")
                          .get();
                      /*print(data.child("email").value);
                      print(data.child("password").value);*/
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
                  child: Text('LOGIN')),
            ],
          ),
        ),
      ),
    );
  }
}
