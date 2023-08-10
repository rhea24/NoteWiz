
import 'package:flutter/material.dart';


class MathPage extends StatefulWidget {
  MathPage({Key? key}) : super(key: key);

  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,

      ),
      body: const Stack(
        children: [Text("hi this is the math page")]
      )
    );
  }
}
