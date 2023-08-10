import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_wiz/gpt_integration/AssetsManager.dart';

import '../globals.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Material(
            color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      chatIndex == 0
                        ? AssetsManager.userImage
                        : AssetsManager.botImage,
                      height: 30,
                      width: 30
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        msg,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    )
                  ]
              ),
            ),
          )
    ]);
  }
}
