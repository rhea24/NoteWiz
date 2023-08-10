
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/animation.dart';
import 'studentSignUp.dart';
import 'teacherSignUp.dart';


class SignupPage extends StatefulWidget {
  SignupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>  with TickerProviderStateMixin {
  late AnimationController controller;
  // late AnimationController controller2;
  late Animation<double> animation;
  // late Animation<double> animation2;

  initState() {


    controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    // controller2 = AnimationController(
    //     duration: const Duration(milliseconds: 1300), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    // animation2 = CurvedAnimation(parent: controller2, curve: Curves.easeIn);
    super.initState();
    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    controller.forward();
    // controller2.forward();
  }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            //   Row(
            // children: [
           Container(
             margin: EdgeInsets.only(left:20,right: 20, bottom: 30),
             child: FadeTransition(
               opacity: animation,
          child: Text("Hello! ",

            style: TextStyle(
              // fontFamily: GoogleFonts.lato()m,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
              fontSize: 32,

            ),

                ),
                //      child: SizedBox(
                //       width: 250.0,
                //       child: DefaultTextStyle(
                //         style:  GoogleFonts.lato(),
                //         //const TextStyle(
                //         //   fontSize: 30.0,
                //         //   fontFamily: GoogleFonts.lato(),
                //         // ),
                //         child: AnimatedTextKit(
                //           animatedTexts: [
                //             TyperAnimatedText('Hello! Are you a teacher or student?'),
                //           ],
                //           onTap: () {
                //             // print("Tap Event");
                //           },
                //         ),
                //       ),
                // ),
                ),
                ),

              Container(
                margin: EdgeInsets.only(left:20,right: 20, bottom: 30),
                child: FadeTransition(
                  opacity: animation,
                  child: Text("Are you a student or teacher?",

                    style: TextStyle(
                      // fontFamily: GoogleFonts.lato()m,
                      color: Colors.white70,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,

                    ),

                  ),
                  //      child: SizedBox(
                  //       width: 250.0,
                  //       child: DefaultTextStyle(
                  //         style:  GoogleFonts.lato(),
                  //         //const TextStyle(
                  //         //   fontSize: 30.0,
                  //         //   fontFamily: GoogleFonts.lato(),
                  //         // ),
                  //         child: AnimatedTextKit(
                  //           animatedTexts: [
                  //             TyperAnimatedText('Hello! Are you a teacher or student?'),
                  //           ],
                  //           onTap: () {
                  //             // print("Tap Event");
                  //           },
                  //         ),
                  //       ),
                  // ),
                ),
              ),

                // ],
                // ),

                Container(
                  margin: EdgeInsets.only(bottom: 25),
                child: FadeTransition(
                opacity: animation,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 15),
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => teacherSignupPage(title: 'Teach Signup Page')),
                            );
                          },
                          child: Text('Teacher',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),),
                          style:  ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent.shade200),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),

                                  )
                              )
                          )

                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 20),
                    width: 150,
                    height: 60,
                    child: ElevatedButton(
                    onPressed: () {

                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentSignupPage(title: 'Student Signup Page')),
                    );
                    },
                    child: Text('Student',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    ),),
                    style:  ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),

                            )
                        )
                    )

                          ),
                  ),
                      ],
                    ),

                ),
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





            ],
          ),
        ),
      ),
    );
   }
}
