
import 'package:flutter/material.dart';


class ClassChatPage extends StatefulWidget {
  ClassChatPage({Key? key}) : super(key: key);

  @override
  _ClassChatPageState createState() => _ClassChatPageState();
}

class _ClassChatPageState extends State<ClassChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,

        ),
        body: Center(
            child:  Text("hiii")
        )
    );
  }
}
