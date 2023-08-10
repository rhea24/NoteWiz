import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'user_info.dart';
import 'user_specifics.dart';
import 'buttonwidget.dart';
import 'pfpwidget.dart';
import 'textfields.dart';
import 'package:note_wiz/globals.dart' as globals;
import 'profile.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // User user = UserSpecifics.myUser;
  // final name = TextEditingController();
  // final email = TextEditingController();
  // final school = TextEditingController();
  final nameController = TextEditingController(text:globals.name);
  final emailController = TextEditingController(text:globals.email);
  final schoolController = TextEditingController(text:globals.school);

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   nameController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  body: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:30, bottom: 15),
                        child: ProfileWidget(
                          imagePath: globals.imagePath,
                          isEdit: true,
                          onClicked: () async {},
                        ),
                      ),
                       SizedBox(height: 30),
                       TextFormField(
                        controller: nameController,
                        //initialValue: globals.name,
                        decoration:  InputDecoration(
                          // icon: Icon(Icons.person),
                          //hintText: globals.name,
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.deepPurpleAccent.shade200)
                        ),

                        onSaved: (String? value) {
                          globals.name = nameController.text;
                          // name = globals.name;
                          // print(globals.name);
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (String? value) {
                        //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                        // },
                      ),
                      // TextFieldWidget(
                      //   label: 'Full Name',
                      //   text: globals.name,
                      //   onChanged: (globals.name = text) {},
                      // ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        //initialValue: globals.name,
                        decoration:  InputDecoration(
                          // icon: Icon(Icons.person),
                          //hintText: globals.name,
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.deepPurpleAccent.shade200)
                        ),

                        onSaved: (String? value) {
                          globals.email = emailController.text;
                          // name = globals.name;
                          // print(globals.name);
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (String? value) {
                        //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                        // },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: schoolController,
                        //initialValue: globals.name,
                        decoration:  InputDecoration(
                          // icon: Icon(Icons.person),
                          //hintText: globals.name,
                          border: OutlineInputBorder(),
                          labelText: 'School',
                          labelStyle: TextStyle(color: Colors.deepPurpleAccent.shade200)
                        ),

                        onSaved: (String? value) {
                          globals.school = schoolController.text;
                          // name = globals.name;
                          // print(globals.name);
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (String? value) {
                        //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                        // },
                      ),
                      const SizedBox(height: 40),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top:20),
                        child: ElevatedButton(
                            onPressed: () {
                              globals.name = nameController.text;
                              globals.email = emailController.text;
                              globals.school = schoolController.text;
                              print(globals.name);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    ProfilePage( )
                                ),
                              );
                            },
                            child: Text('Save Edits',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple.shade200),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),

                                    )
                                )
                            )),
                      )
                    ],
                  ),

          );

  }
}