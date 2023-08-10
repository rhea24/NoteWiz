import 'package:flutter/material.dart';
import 'signup_directory.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'signup.dart';
// import 'dashboard.dart';
import 'globals.dart' as globals;
import 'main.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        // flexibleSpace: Container(
        //
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
              Container(
                //margin: EdgeInsets.only(left: 20,top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20), // Image border
                    //   child: SizedBox.fromSize(
                    //     size: Size.fromRadius(32), // Image radius
                    //     child: Image.asset('assets/images/filled_logo.png', height: 25, width: 32,),
                    //   ),
                    // ),
                    Container(
                      // margin: EdgeInsets.only(left:25, right:25),
                      child: Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 35
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(

                margin: EdgeInsets.only(left: 30,right: 30, top: 40),
                child: TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width:2, color: Colors.deepPurple.shade200)


                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      //hintText: "Name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)
                  ),
                  //decoration: InputDecoration(

                  //labelText: '',
                  //),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,bottom: 5, top: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(width:2 ,color: Colors.deepPurple.shade200)
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      //hintText: "Name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.white)
                  ),
                  //decoration: InputDecoration(

                  //labelText: '',
                  //),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 30, bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.deepPurpleAccent,
                        value: globals.autoLogin,   onChanged: (bool? newValue) {
                      setState(() {
                        globals.autoLogin = newValue!;
                      });
                    },
                    ),
                    Container(
                      child: Text("Remember Me",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              )),
                    )
                  ],
                ),
              ),



              Container(
                width: 150,
                height:60,
                margin: EdgeInsets.only(bottom: 25,top: 10),
                child: ElevatedButton(

                    onPressed: () {
                      // 1. Get the username(email) and password
                      print(emailController.text);
                      print(passwordController.text);

                      // 2. Call Firebase authenticaiton and verify the username and password
                      FirebaseAuth.instance.signInWithEmailAndPassword( email: emailController.text, password: passwordController.text)
                         .then((value) {
                        print("You have successfully logged in");
                        // go to home screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')),
                        );
                      }).catchError((e) {
                        print("Failed to Login");
                        print(e);

                      });

                    },
                    child: Text('Login',
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

              // Container(
              //   width: 100,
              //   height:60,
              //   margin: EdgeInsets.only(bottom: 0),
              //   child: ElevatedButton(
              //       onPressed: () {
              //
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => SignupPage(title: 'Signup Page')),
              //         );
              //       },
              //       child: Text('Create Account',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),),
              //       style:  ButtonStyle(
              //           backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
              //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //               RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(25.0),
              //
              //               )
              //           )
              //       )
              //
              //   ),
              // ),

            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );


  }


}

