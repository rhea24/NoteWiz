// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_wiz/feature_pages/Summary/SummaryPage.dart';
import 'course pages/math.dart';
import 'login.dart';
import 'package:flutter/material.dart';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

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

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Courses", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.shade100,
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 5),
                child: const Text(
                  'My Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Math',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // open math class transcript
              },
            ),
            const Divider(
              height: 10,
              thickness: 2,
              indent: 5,
              endIndent: 5,
              color: Colors.black12,
            ),
            ListTile(
              title: const Text(
                'Science',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // open science class transcript
              },
            ),
            const Divider(
              height: 10,
              thickness: 2,
              indent: 5,
              endIndent: 5,
              color: Colors.black12,
            ),

            ListTile(
              title: const Text(
                'History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),
            const Divider(
              height: 10,
              thickness: 2,
              indent: 5,
              endIndent: 5,
              color: Colors.black12,
            ),
            ListTile(
              title: const Text(
                'English',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {},
            ),

            const Divider(
              height: 10,
              thickness: 2,
              indent: 5,
              endIndent: 5,
              color: Colors.black12,
            ),

            const Padding(padding: EdgeInsets.only(bottom: 40)),

            Container(
              width: 250,
              height: 45,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.deepPurpleAccent.shade100),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white70,
                        size: 36.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Add Course",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )),
            ),

            // const Divider(
            // height: 10,
            // thickness: 2,
            // indent: 5,
            // endIndent
            // }: 5,
            //           color: Colors.black12,
            //         ),
          ],
        ),
        //)
      ),
      body:
          //Column(
          //   children: [
          //     CustomScrollView(
          //       center: centerKey,
          //       slivers: <Widget>[
          //         SliverList(
          //           key: centerKey,
          //           delegate: SliverChildBuilderDelegate(
          //                 (BuildContext context, int index) {
          //               return buildCard("Math", "Math 1010", 'assets/images/lightblue.jpg');
          //                   //               buildCard("Science", "Science 1010", 'assets/images/lightpurple.jpg'),
          //                   //               buildCard("History", "History 1010", 'assets/images/lightblue.jpg'),
          //                   //               buildCard("English", "English 1010", 'assets/images/lightpurple.jpg'),
          //             },
          //             childCount: bottom.length,
          //           ),
          //         ),
          //         Card(
          //             borderOnForeground : true,
          //             color: Colors.grey,
          //
          //             clipBehavior: Clip.antiAlias,
          //             child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Icon(Icons.add,
          //                     size: 25,
          //                     color: Colors.white,
          //                   ),
          //                 ]
          //             )
          //         )
          //       ],
          //     ),
          //
          //
          //   ],
          //
          //
          // ),

          // SingleChildScrollView(
          //   scrollDirection: Axis.vertical,
          //   padding: const EdgeInsets.only(left:5,right:5),
          //   child: Column(
          //     children: [

          // GestureDetector(
          //  onTap: () {
          //    Navigator.push(
          //              context,
          //              MaterialPageRoute(builder: (context) => MathPage()),
          //            );
          //  },
          // // child: SingleChildScrollView(
          //    child:
          ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          buildCard("Calculus, Part I ", "Math 1400", 'assets/images/math.png'),
          buildCard("Intro to Literature and Law", "ENGL 0060", 'assets/images/english.jpeg'),
          buildCard("History and Theory I", "ARCH 5110", 'assets/images/history.jpg'),
          GestureDetector(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SummaryPage()),
              )
            },
            child: buildCard(
                "Quantum Physics of Materials", "MSE 2210", 'assets/images/quantum.png'),
          ),
          Container(
              height: 75,
              width: 50,
              margin: EdgeInsets.all(15),
              child: const Card(
                  borderOnForeground: true,
                  color:  Color(0xffd8d8d8),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ]))),
        ],
      ),
      // )
      //  ),
      // ],
      // ),
      // ),
    );
    // ),
    // );
    //     ),
    //   ),
    // );
  }
}
