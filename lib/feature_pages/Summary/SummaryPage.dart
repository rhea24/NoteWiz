import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note_wiz/gpt_integration/api_service.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:note_wiz/globals.dart' as globals;
import 'package:flutter/gestures.dart';
class SummaryPage extends StatefulWidget {
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String displayText = 'Loading...';
  final database = FirebaseDatabase.instance.ref();
  final transcribeController  = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    database.child('audio_transcript/live1/text').onValue.listen((event) {
      final String live_text = event.snapshot.value.toString();
      setState(() {
        displayText = live_text;
      });
    });
  }

  // DatabaseReference child = ref.child("name");
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top:Radius.circular(20),
          )
        ),
        builder: (context) => DraggableScrollableSheet(
          // controller: ,
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          minChildSize: 0.2,
          builder: (context, scrollController) =>  SingleChildScrollView(
            controller: scrollController,
      child:   FutureBuilder<String>(
                future: getSummary(realtime_transcript),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Text("Summary", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 20),)),

                      Container(
                        margin: EdgeInsets.all(20),
                          child: Text(snapshot.data!, style: TextStyle(height: 1.5)))
                    ];
                  } else {
                    children = <Widget>[
                      Container(
                        height: 300,

                        child: const LoadingIndicator(
                            indicatorType: Indicator.ballClipRotateMultiple, /// Required, The loading type of the widget
                            colors: [Colors.black],       /// Optional, The color collections
                            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                            backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                            pathBackgroundColor: Colors.white   /// Optional, the stroke backgroundColor
                        ),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  );
                }
              )
      //Text("data"),
    ),
        ));
  }
  //
  // Stream<DatabaseEvent> stream = ref.onValue;

  String realtime_transcript = '''

  ''';


  @override
  Widget build(BuildContext context) {
    final live_transcript = database.child('audio_transcript/live1/');
    final auth = FirebaseAuth.instance;
    globals.lectureTranscript = realtime_transcript;
    final DatabaseReference ref  = FirebaseDatabase.instance.ref('audio_transcript/live1/text');
    Stream<DatabaseEvent> stream = ref.onValue;
        stream.listen((DatabaseEvent event) {
          realtime_transcript = event.snapshot.value.toString(); // DataSnapshot
        });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Lecture Transcript"),
        titleTextStyle: TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),
      ),
      body:
      ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Container(
          //   margin: EdgeInsets.only(left:15, top:30),
          //     child: Text("Lecture Transcript:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black87),)),
          Container(
            margin: EdgeInsets.all(25),
              child: FutureBuilder<List<String>>(
                  future: getKeyWords(displayText),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                    List<TextSpan> children;
                    if (snapshot.hasData) {
                      children =
                          highlightOccurrences(realtime_transcript, snapshot.data ?? []);
                    } else {
                      children = <TextSpan>[TextSpan(text: realtime_transcript)];
                    }
                    return RichText(
                      text: TextSpan(
                        children: children,
                        style: const TextStyle(fontFamily: "Gotham", fontWeight: FontWeight.normal, fontSize: 17.5, color: Colors.black, height: 1.75),
                      ),
                    );
                  }
              )
          ),
          Container(
          width: 200,
          height: 55,
          margin: EdgeInsets.all(30),


          child: ElevatedButton(

              onPressed: () => _showModalBottomSheet(context),
            child:  const Text('Summary',
    style: const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: 25,
    ),
    ),
              style:  ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent.shade100),

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),

                      )
                  )
              )
             ),

        ),
    ],
      ),
    );
  }

  Future<String> getSummary(String lectureTranscript) async {
    var messages = await ApiService.sendMessage(message: "Give me a bulleted summary of the following lecture transcript $lectureTranscript", modelId: 'gpt-3.5-turbo');
    getKeyWords(lectureTranscript);
    return messages[messages.length-1].msg ?? "Failed to generate summary";
  }


  Future<String> getDefinition(String word) async {
    var definition = await ApiService.sendMessage(message: "Give me a brief definition of $word", modelId: 'gpt-3.5-turbo');
    // getKeyWords(lectureTranscript);
    return definition[definition.length-1].msg ?? "Failed to generate definition";
  }

  Future<List<String>> getKeyWords(String lectureTranscript) async {
    var keywords = await ApiService.sendMessage(message: "Give me a numbered list of key words from the following lecture transcript $lectureTranscript", modelId: 'gpt-3.5-turbo');
    if (keywords[keywords.length-1].msg == null) {
      return [];
    } else {
      String response = keywords[keywords.length-1].msg!;
      String trimmedResponse = "";
      int index = response.indexOf('1.');
      trimmedResponse = response.substring(index).trim();
      LineSplitter ls = LineSplitter();
      List<String> words = ls.convert(trimmedResponse);
      for (int i = 0; i < words.length; i++) {
        int ind = words[i].indexOf(". ");
        words[i] = words[i].substring(ind+1).trim();
      }
      print("words $words");
      return words;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vocab Notes'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<TextSpan> highlightOccurrences(String source, List<String> queries) {
    if (queries.isEmpty) {
      return <TextSpan>[TextSpan(text: source)];
    }

    final List<Match> matches = <Match>[];
    for (int i = 0; i < queries.length; i++) {
      matches.addAll(queries[i].trim().toLowerCase().allMatches(source.toLowerCase()));
    }


    if (matches.isEmpty) {
      return <TextSpan>[TextSpan(text: source)];
    }
    matches.sort((Match a, Match b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;
    final List<TextSpan> children = <TextSpan>[];
    const Color matchColor = Color(0xFF602885);
    for (final Match match in matches) {
      if (match.end <= lastMatchEnd) {
        // already matched -> ignore
      } else if (match.start <= lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.end),
          recognizer:TapGestureRecognizer()..onTap = ()=> showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Vocab Notes'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[

                TextButton(
                  onPressed: () => Navigator.pop(context, 'DONE'),
                  child: const Text('DONE'),
                ),
              ],
            ),
          ),
        )
        );
      } else {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));


        children.add(TextSpan(
          recognizer:TapGestureRecognizer()..onTap = ()=> showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(source.substring(match.start, match.end)),
              content:
              FutureBuilder<String>(
                  future: getDefinition(source.substring(match.start, match.end)),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    // List<TextSpan> children;
                    // /List<TextSpan> children;
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        Text(snapshot.data!, style: TextStyle(fontSize: 15, height: 1.3),)
                      ];
                    } else {
                      children = <Widget>[
                        Container(
                          height: 200,

                          child: const LoadingIndicator(
                              indicatorType: Indicator.ballClipRotateMultiple, /// Required, The loading type of the widget
                              colors: [Colors.black],       /// Optional, The color collections
                              strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                              backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                              pathBackgroundColor: Colors.white   /// Optional, the stroke backgroundColor
                          ),
                        )
                      ];
                    }
                    return SizedBox(
                      height:300,

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),


                    );

                  }
              ),
              // FutureBuilder<String>(
              //     future: getDefinition(source.substring(match.start, match.end)),
              //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              //       // List<TextSpan> children;
              //       //List<TextSpan> children;
              //       String children;
              //       if (snapshot.hasData) {
              //        // children =  <TextSpan>[
              //        //   TextSpan(text: snapshot.data!)
              //        // ];
              //         children = snapshot.data!;
              //       } else {
              //         children = "Loading";
              //         // ];
              //         // <TextSpan>[
              //         //   TextSpan(text:"Loading")
              //         //   // Text("Loading")
              //         // ];
              //         // }
              //       }
              //           return
              //             RichText(
              //             text: TextSpan(
              //               text: children,
              //               style: const TextStyle(color: Colors.black),
              //             ),
              //           );
              //
              //         }
              // ),


                    //),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'DONE'),
                  child: const Text('DONE'),
                ),

              ],
            ),
          ),
          text: source.substring(match.start, match.end),
          style:
          TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.blue.shade100),
        ));
        // children.add(TextSpan(
        //   recognizer:TapGestureRecognizer()..onTap = ()=> showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //       title: const Text('Vocab'),
        //       content: const Text('AlertDialog description'),
        //       actions: <Widget>[
        //         TextButton(
        //           onPressed: () => Navigator.pop(context, 'Cancel'),
        //           child: const Text('Cancel'),
        //         ),
        //         TextButton(
        //           onPressed: () => Navigator.pop(context, 'OK'),
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     ),
        //   ),
        //   text: source.substring(match.start, match.end),
        //   style:
        //   TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.deepPurpleAccent.shade100),
        // ));
      }

      if (lastMatchEnd < match.end) {
        lastMatchEnd = match.end;
      }
    }

    if (lastMatchEnd < source.length) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, source.length),
      ));
    }

    return children;
  }


}