import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class SpeechRecognitionPage extends StatefulWidget {
  SpeechRecognitionPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}


class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  late String chatInput;
  // SpeechToText _speechToText = SpeechToText();
  // bool _speechEnabled = false;
  // String _lastWords = '';
  // @override
  // void initState() {
  //   super.initState();
  //   _initSpeech();
  // }
  //
  // /// This has to happen only once per app
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }
  //
  // /// Each time to start a speech recognition session
  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }
  //
  // /// Manually stop the active speech recognition session
  // /// Note that there are also timeouts that each platform enforces
  // /// and the SpeechToText plugin supports setting timeouts on the
  // /// listen method.
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }
  //
  // /// This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }

  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button to speak!';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Speech Demo'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //           padding: EdgeInsets.all(16),
    //           child: Text(
    //             'Recognized words:',
    //             style: TextStyle(fontSize: 20.0),
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             padding: EdgeInsets.all(16),
    //             child: Text(
    //               // If listening is active show the recognized words
    //               _speechToText.isListening
    //                   ? '$_lastWords'
    //               // If listening isn't active but could be tell the user
    //               // how to start it, otherwise indicate that speech
    //               // recognition is not yet ready or not supported on
    //               // the target device
    //                   : _speechEnabled
    //                   ? 'Tap the microphone to start listening...'
    //                   : 'Speech not available',
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed:
    //     // If not yet listening for speech start, otherwise stop
    //     _speechToText.isNotListening ? _startListening : _stopListening,
    //     tooltip: 'Listen',
    //     child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme
            .of(context)
            .primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>
              setState(() {
                _text = val.recognizedWords;
                chatInput = _text;

                print(_text); // added to code (might not work)
                if (val.hasConfidenceRating && val.confidence > 0) {
                  _confidence = val.confidence;
                }
                if (_text == "Open object detector" ||
                    _text == "Open object recognition" ||
                    _text == "Object detection" ||
                    _text == "Object recognizer" || _text == "Detect Objects" ||
                    _text == "Recognize objects") {
                  print("RAHAHHAHAHHAHAH");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => HomeView())
                  // );
                }
                // if (_text == "Open letter recognition"){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LetterRecognitionPage(title: "Letter Recognition"))
                //   );
                // }
              }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
//}

// import 'dart:collection';
//
// import 'package:collection/collection.dart';
//
// import 'package:flutter/material.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
//
// import 'package:avatar_glow/avatar_glow.dart';
//
// import 'package:flutter/material.dart';
// import 'package:highlight_text/highlight_text.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
//
//
// class GPTTranscriberPage extends StatefulWidget {
//   GPTTranscriberPage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _GPTTranscriberPageState createState() => _GPTTranscriberPageState();
// }
//
// class _GPTTranscriberPageState extends State<GPTTranscriberPage> {
//
//   // final LinkedHashMap<String, HighlightedWord> _highlights = {
//   //   'flutter': HighlightedWord(
//   //     onTap: () => print('flutter'),
//   //     textStyle: const TextStyle(
//   //       color: Colors.blue,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   ),
//   //   'voice': HighlightedWord(
//   //     onTap: () => print('voice'),
//   //     textStyle: const TextStyle(
//   //       color: Colors.green,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   ),
//   //   'subscribe': HighlightedWord(
//   //     onTap: () => print('subscribe'),
//   //     textStyle: const TextStyle(
//   //       color: Colors.red,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   ),
//   //   'like': HighlightedWord(
//   //     onTap: () => print('like'),
//   //     textStyle: const TextStyle(
//   //       color: Colors.blueAccent,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   ),
//   //   'comment': HighlightedWord(
//   //     onTap: () => print('comment'),
//   //     textStyle: const TextStyle(
//   //       color: Colors.green,
//   //       fontWeight: FontWeight.bold,
//   //     ),
//   //   ),
//   // };
//
//   stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   String _text = 'Press the button and start speaking';
//   double _confidence = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('wee woo'),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: AvatarGlow(
//         animate: _isListening,
//         glowColor: Theme.of(context).primaryColor,
//         endRadius: 75.0,
//         duration: const Duration(milliseconds: 2000),
//         repeatPauseDuration: const Duration(milliseconds: 100),
//         repeat: true,
//         child: FloatingActionButton(
//           onPressed: _listen,
//           child: Icon(_isListening ? Icons.mic : Icons.mic_none)
//         ),
//     ),
//     body: SingleChildScrollView(
//     reverse: true,
//     child: Container(
//     padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
//     child: TextHighlight(
//     text: _text,
//     words: _highlights,
//     textStyle: const TextStyle(
//     fontSize: 32.0,
//     color: Colors.black,
//     fontWeight: FontWeight.w400,
//     ),
//       ),
//
//     ),
//     ),
//     );
//
//   }
//
//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             _text = val.recognizedWords;
//             print(_text); // added to code (might not work)
//             if (val.hasConfidenceRating && val.confidence > 0) {
//               _confidence = val.confidence;
//
//             }
//             if (_text == "Open object detector" || _text == "Open object recognition" || _text == "Object detection" || _text == "Object recognizer" ||_text == "Detect Objects"|| _text == "Recognize objects"){
//               print('hi');
//               // Navigator.push(
//               //     context,
//               //     MaterialPageRoute(builder: (context) => HomeView())
//               // );
//             }
//             // if (_text == "Open letter recognition"){
//             //   Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => LetterRecognitionPage(title: "Letter Recognition"))
//             //   );
//             // }
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }
// }
}