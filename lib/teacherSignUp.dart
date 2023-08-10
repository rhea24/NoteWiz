import 'package:flutter/material.dart';
import 'globals.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'globals.dart' as globals;

class teacherSignupPage extends StatefulWidget {
  teacherSignupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _teacherSignupPageState createState() => _teacherSignupPageState();
}

class _teacherSignupPageState extends State<teacherSignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/images/appbar.png'),
        //         fit: BoxFit.fill
        //     ),
        //
        //   ),
        // ),

        //title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.deepPurple.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Expanded(
                flex: 12,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,top: 30, bottom: 30),
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Colors.deepPurple.shade100,
                              fontWeight: FontWeight.w500,
                              fontSize: 35
                          )
                      ),
                    ),

                  ],
                  // width: 200,
                  // height: 75,

                  //Image(
                  //image: NetworkImage('https://codingmindsacademy.com/img/my/logo1.png'),
                ),
              ),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:30, bottom: 7),
                    child: Text("Name",
                        style: TextStyle(
                            color: Colors.deepPurple.shade100,
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        )
                    ),
                  ),
                ],
              ),
              //),

              // Expanded(
              //   flex: 10,
              //   child: Container(
              //     margin: EdgeInsets.all(20),
              //     child: Text(
              //       'Signup Page',
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              // ),

              Expanded(
                flex: 60,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                      child: TextField(
                        controller: nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),

                            ),
                            //hintText: "Name",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)
                        ),
                        //decoration: InputDecoration(

                        //labelText: '',
                        //),
                      ),
                    ),


                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:30, bottom: 7),
                          child: Text("Email",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade100,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              )
                          ),
                        ),
                      ],
                    ),


                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),

                            ),
                            //hintText: "Emai",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)
                        ),
                        //decoration: InputDecoration(

                        //labelText: '',
                        //),
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:30, bottom: 7),
                          child: Text("School",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade100,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              )
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                      child: TextField(
                        controller: schoolController,
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),

                            ),
                            //hintText: "Emai",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)
                        ),
                        //decoration: InputDecoration(

                        //labelText: '',
                        //),
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:30, bottom: 7),
                          child: Text("Password",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade100,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              )
                          ),
                        ),
                      ],
                    ),


                    Container(
                      margin: EdgeInsets.only(left: 30,right: 30,bottom: 30),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),

                            ),
                            //hintText: "Name",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black)
                        ),
                        //decoration: InputDecoration(

                        //labelText: '',
                        //),
                      ),
                    ),

                    Container(
                      width: 300,
                      height:70,
                      margin: EdgeInsets.only(top: 15,right:20,left:20, bottom: 20),
                      child: ElevatedButton(

                          onPressed: () {
                            // 1. get the input username and password
                            globals.email = emailController.text;
                            globals.name = nameController.text;
                            globals.school = schoolController.text;
                            globals.accountType = "Teacher";
                            globals.createdAccount = true;
                            print(globals.accountType);

                            print(globals.name);
                            print(globals.email);
                            print(globals.school);
                            // 2. send and save the username/password to Firebase

                            // FirebaseService.instance.callFunction()
                            //    .then((res) {
                            //       code
                            //    })
                            //    .catchError((e) {
                            //       code
                            //    });

                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text)
                                .then((value) {
                              print("User Uid: " + value.user!.uid);
                              print("Successfully sign up!");
                              // save the user information in Realtime Database

                            // use Firebase Database
                              FirebaseDatabase.instance.ref().child("teachers/${value.user!.uid}").set(
                                  {
                                    "Account Type" : "Teacher",
                                    "Name" : nameController.text,
                                    "Email" : emailController.text,
                                    "Password" : passwordController.text,
                                  }
                              ).then((value) {
                                // go back to Login screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage(title: 'Log In')),
                                );
                              }).catchError((e){
                                print(e);
                                print("Failed to save the user information.");
                              });

                            }).catchError((e) {
                              print("Failed to sign up!");
                              print(e);
                            });


                          },
                          child: Text('Create Teacher Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),),
                          style:  ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade200),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27.0),

                                  )
                              )
                          )

                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 50,
                    //       child: Container(
                    //         margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                    //         child: TextField(
                    //           controller: firstnameController,
                    //           obscureText: false,
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(),
                    //             labelText: 'First Name',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //
                    //     Expanded(
                    //       flex: 50,
                    //       child: Container(
                    //         margin: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                    //         child: TextField(
                    //           controller: lastnameController,
                    //           obscureText: false,
                    //           decoration: InputDecoration(
                    //             border: OutlineInputBorder(),
                    //             labelText: 'Last Name',
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),

              ),



            ],
          ),
        ),
      ),
    );
  }
}
