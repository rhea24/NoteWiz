import 'package:flutter/material.dart';
import 'package:note_wiz/dashboard.dart';
import 'package:note_wiz/feature_pages/Quizzing/QuizScreen.dart';
import 'package:note_wiz/gpt_integration/ChatScreen.dart';
import 'ClassChat.dart';
import 'feature_pages/Summary/SummaryPage.dart';
import 'globals.dart' as globals;
import 'login.dart';
import 'voice_recording.dart';
import 'start_page.dart';
import 'profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'voicerecord2.dart';
import 'voicerecord3.dart';
import 'voicerecord4.dart';
import 'chatgpt.dart';
import 'chat_gpt_sdk/full_example.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'feature_pages/Summary/SummaryPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteWiz',
      theme: ThemeData(
        fontFamily: 'Gotham',
        primaryColor: Colors.black,
        hintColor : Colors.blueAccent.shade200,
        primarySwatch: Colors.blueGrey,
      ),
      // home: const ChatScreen(),
      home: StartPage(title: "",),
    );
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  int _currentIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _pagelist= [];

  @override
  void initState(){
    _pagelist
      // ..add(SchedulePage(title:"",))
      ..add(SummaryPage())
      ..add(DashboardPage(title:"",))
      ..add(QuizScreen())
      // ..add(KitVideoPage(title:"",))
      // ..add(ChatGPTPage(title:"",))
    ..add(ProfilePage());
    //..add(ProfilePage());

    super.initState();
  }



  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text(widget.title),
      //),
      body: _pagelist[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
       // fixedColor: Colors.deepPurple.shade200,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.transcribe_rounded),
              label: '',
                backgroundColor: Colors.deepPurpleAccent.shade100,

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books_rounded),
                label: '',
              backgroundColor: Colors.deepPurpleAccent.shade100,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.textsms_rounded),
                label: '',
              backgroundColor: Colors.deepPurpleAccent.shade100,
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: '',
              backgroundColor: Colors.deepPurpleAccent.shade100,

            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.lightBlueAccent
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}