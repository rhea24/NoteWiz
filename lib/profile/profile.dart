// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

import '../globals.dart' as globals;
import '../main.dart';
import 'package:flutter/cupertino.dart';
import 'user_info.dart';
import 'user_specifics.dart';
import 'buttonwidget.dart';
import 'pfpwidget.dart';
import 'editprofile.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CardType {
  standard,
  tappable,
  selectable,
}

List<Course> courses = [];

class Course {
  Course({
    required this.name,
    required this.courseId,
    required this.imgPath,
    this.cardType = CardType.standard,
  });

  final String name;
  final String courseId;
  final String imgPath;
  final CardType cardType;
}
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  Widget buildCard(String title, String description, String imgPath) {
    return Container(
        margin: EdgeInsets.all(15),
        child: Card(
            borderOnForeground: true,
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              Image(image: AssetImage(imgPath)),
              ListTile(
                // leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(title),
                subtitle: Text(
                  description,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              )
            ])));
  }

  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.myUser;


    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.only(top:30),
                  // height: 150,
                  // width: 150,
                  child: Container(
                      height:165,
                      child: Image(image: AssetImage("assets/images/image.jpg"))),
                  // child: ProfileWidget(
                  //   imagePath:  'assets/images/image.jpg',
                  //   onClicked: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (context) => EditProfilePage()),
                  //     );
                  //   },
                  // ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(globals.accountType,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.black26
                        ),),
                    ),
                    Text(globals.name,
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Colors.black
                    ),),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(globals.school,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black54
                        ),),
                    ),
                    // Text(globals.school,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 30,
                    //       color: Colors.black
                    //   ),),
                    Container(
                      width: 180,
                      height: 45,
                      margin: EdgeInsets.only(top: 20),
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.deepPurple.shade200,
                        label: Text('Settings'),
                        icon:  Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 36.0,
                            ),

                          onPressed: ()
                      {

                      }),
                    ),
                    Container(
                      padding: EdgeInsets.only(left:20,top:30),
                      alignment: Alignment.centerLeft,
                      child: Text('Active Courses',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500

                      ),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 250.0,
                      child:

                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              width: 240.0,
                              child:  buildCard("Calculus, Part I ", "Math 1400", 'assets/images/math.png'),
                          ),
                          Container(
                            width:240.0,

                           child: buildCard("Intro to Literature and Law", "ENGL 0060", 'assets/images/english.jpeg'),
                          ),

                          Container(
                            width: 240.0,

                            child:
                              buildCard("History and Theory I", "ARCH 5110", 'assets/images/history.jpg'),
                          ),

                          Container(
                            width:240.0,

                            child: buildCard(
                                "Quantum Physics of Materials", "MSE 2210", 'assets/images/quantum.png'),
                          ),


                        ],
                      ),

                    ),

                    Container(
                      width: 250,
                      height: 45,
                      // margin: EdgeInsets.only(top:5),
                      child: FloatingActionButton.extended(
                          backgroundColor: Colors.deepPurple.shade200,
                          label: Text('Log Out'),
                          icon:  const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 36.0,
                          ),

                          onPressed: ()
                          {
                            globals.autoLogin = false;
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LoginPage(title: "")),
                            );

                          }),
                    ),
                  ],
                )


              ],
            ),
          ),
    );
  }


}