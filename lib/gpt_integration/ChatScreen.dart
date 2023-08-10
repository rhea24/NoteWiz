import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_wiz/globals.dart';
import 'api_constants.dart';
import 'package:note_wiz/gpt_integration/AssetsManager.dart';
import 'package:note_wiz/gpt_integration/ChatWidget.dart';
import 'package:note_wiz/gpt_integration/api_service.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'ChatModel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false; // for loading 3 dots

  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        title: const Text("ChatGPT"),
        actions:[IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_rounded, color: Colors.white))]
      ),
      body: SafeArea(
        child: Column(children:[
          Flexible(
            child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context,index) {
                  return ChatWidget(
                      msg: chatList[index].msg ?? "helloooooooooo",
                      chatIndex: chatList[index].chatIndex ?? 0);
                })
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
                color: Colors.blueGrey,
                size: 18),
          ],
          const SizedBox(height: 15,),
          Material(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  children: [
                    Expanded(
                      child: TextField(controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessage();
                        },
                        decoration: const InputDecoration.collapsed(hintText: "How can I help you", hintStyle: TextStyle(color: Colors.grey)),
                    )
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMessage();
                        },
                        icon: const Icon(
                            Icons.send,
                            color: Colors.grey
                        )
                    )
                  ]
              ),
            ),
          )
        ],
        ),
      ),
    );
  }
  Future<void> sendMessage() async {
    String text = textEditingController.text;
    try {
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: text, chatIndex: 0));
        textEditingController.clear();
      });
      // print(text);
      chatList.addAll(await ApiService.sendMessage(
          message: text,
          modelId: "gpt-3.5-turbo"
      ));
      for (int i = 0; i < chatList.length; i++) {
        print(i);
        print(chatList[i].chatIndex);
        print(chatList[i].msg);
      }
    } catch (error) {
      print("error $error");
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }
}