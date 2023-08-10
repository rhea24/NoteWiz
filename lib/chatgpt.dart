




//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'login.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/animation.dart';
// import 'studentSignUp.dart';
// import 'teacherSignUp.dart';
// import 'package:http/http.dart';
//
// class ChatGPTPage extends StatefulWidget {
//   ChatGPTPage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _ChatGPTPageState createState() => _ChatGPTPageState();
// }
//
// class _ChatGPTPageState extends State<ChatGPTPage> {
//   late final TextEditingController promptController;
//   String responseTxt = '';
//   late ResponseModel _responseModel;
//
//   get http => null;
//
//
//
//
//   @override
//   void initState() {
//     promptController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     promptController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         // flexibleSpace: Container(
//         //   decoration: BoxDecoration(
//         //     image: DecorationImage(
//         //         image: AssetImage('assets/images/appbar.png'),
//         //         fit: BoxFit.fill
//         //     ),
//         //
//         //   ),
//         // ),
//
//         //title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//             PromptBldr(responseTxt: responseTxt),
//             TextFormFieldBldr(
//                 promptController: promptController, btnFun: completionFun),
//
//           ],
//
//       ),
//     );
//   }
//
//   completionFun() async{
//     setState(() => responseTxt = 'Loading...');
//
//     final response = await http.post(
//       Uri.parse('https://api.openai.com/v1/completions'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer${dotenv.env['token']}'
//       },
//       body:jsonEncode(
//         {
//         "model": "text-davinci-003",
//         "prompt" : promptController.text,
//         "max_tokens": 250,
//         "temperature" : 0,
//         "top_p": 1,
//       },
//       ),
//     );
//
//     setState(() {
//       _responseModel = _responseModel.fromJson(response.body);
//       responseTxt = _responseModel.choices[0]['text'];
//       debugPrint(responseTxt);
//     },
//     );
//
// }
//
// }
//
// class ResponseModel {
//   ResponseModel fromJson(body) {}
// }
//
//
//
//
// class TextFormFieldBldr extends StatelessWidget {
//    TextFormFieldBldr(
//       {super.key, required this.btnFun, required this.promptController});
//   final TextEditingController promptController;
//   final Function btnFun;
//
//   @override
//   Widget build (BuildContext context)
//   {
//     return Align(
//         alignment: Alignment.bottomCenter,
//         child:Padding(
//           padding: const EdgeInsets.only(left:10, right:10, bottom: 50),
//           child: Row
//             (
//             children: [
//               Flexible(
//                   child: TextFormField(
//                     cursorColor: Colors.blue,
//                     controller: promptController,
//                     autofocus: true,
//                     style: const TextStyle(color: Colors.blue, fontSize: 20),
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Colors.black,
//                         ),
//                         borderRadius:   BorderRadius.circular(5.5),
//                       ),
//                       enabledBorder:const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black
//                         ),
//                       ),
//                       filled: true,
//                       fillColor:  Colors.black,
//                       hintText: "Ask me anything!",
//                       hintStyle: const TextStyle(color: Colors.grey),
//                     ),
//                   )
//               ),
//               Container(
//                 color: Colors.green,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: IconButton(
//                       onPressed: () => btnFun(),
//                       icon: const Icon(
//                         Icons.send,
//                         color: Colors.white,
//                       )
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//     );
//   }
//
//
// }
//
//
// class PromptBldr extends StatelessWidget{
//   const PromptBldr({
//   super.key,
//   required this.responseTxt,
// });
//
// final String responseTxt;
// @override
// Widget build(BuildContext context){
//   return Container(
//     height: MediaQuery.of(context).size.height / 1.35,
//     color: Colors.black,
//     child:Align(
//       alignment: Alignment.bottomLeft,
//       child: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child:Text(
//             responseTxt,
//             textAlign: TextAlign.start,
//             style:TextStyle(fontSize:25, color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   );
// }
// }
//
