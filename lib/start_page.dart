import 'dart:ui';
import 'main.dart';
import 'login.dart';
import 'signup_directory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        //backgroundColor: Colors.deepPurpleAccent.shade200 ,
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
   //   ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 30,
                child: Shimmer.fromColors(
                  baseColor: Colors.deepPurpleAccent.shade700,

                    highlightColor: Colors.deepPurple.shade400,
                    child: Image.asset(
                      'assets/images/proto_logo.png',
                      height: 160,
                      width: 220,
                    //fit: BoxFit.cover,
                      )

                ),
              ),
              // Expanded(
              //     flex: 30,
              //     child: Image.asset(
              //       'assets/images/proto_logo.png',
              //       height: 160,
              //       width: 220,)
              //
              // ),
              Expanded(
                  flex: 10,
                  child: Container(
                    // margin: EdgeInsets.only(left: 10,right: 10),
                     child:
                     SizedBox(
                    width: 300.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 25.0,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w700,
                      ),

                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Welcome to NoteWiz!',
                      speed: const Duration(milliseconds: 60),),
                        ],
                        isRepeatingAnimation: false,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                     //Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // children: [
                    //     Text(
                    //       "Welcome to [APP NAME]",
                    //       style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.bold
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                        ),
                      ),
              Expanded(
                  flex: 25,
                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        width: 300,
                        height: 75,

                        child: ElevatedButton(
                          onPressed: (){

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyHomePage(title: 'Home')),
                              );
                            // if(globals.autoLogin && globals.createdAccount) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) =>
                            //         MyHomePage(title: 'Home')),
                            //   );
                            // }
                            // else
                            //   {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) =>
                            //           LoginPage(title: 'Log In')),
                            //     );
                              },




                          child: Text("Log In",
                              style:TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                              )),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent.shade200),

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27.0),
                                    //side: BorderSide(color: Colors.black)
                                  )
                              )
                          ),
                        ),

                      ),

                      Container(
                        margin: EdgeInsets.only(left:10,right: 10, top: 14, bottom: 30),
                        width: 300,
                        height: 75,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupPage(title: 'Sign Up Page')),
                            );

                          },
                          child: Text("Create Account",
                              style:TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700

                              )),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27.0),
                                    //side: BorderSide(color: Colors.black)
                                  )
                              )
                          ),
                        ),
                      ),

                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }


}