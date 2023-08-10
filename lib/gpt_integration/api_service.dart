import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:note_wiz/gpt_integration/api_constants.dart';

import 'ChatModel.dart';

class ApiService {
  // static Future<void> getModels() async {
  //   try {
  //     var response = await http.get(
  //       // Uri.parse("$BASE_URL/models"),
  //       Uri.parse("$BASE_URL/chat/completions"),
  //       headers: {"Authorization": "Bearer $API_KEY"},
  //     );
  //     Map jsonResponse = jsonDecode(response.body);
  //
  //   //  Map? jsonResponse = jsonDecode(response.body);
  //
  //     if (jsonResponse["error"] != null) {
  //       print(
  //           'jsonResponse["error"]["message"] ${jsonResponse["error"]["message"]}');
  //       throw HttpException(jsonResponse["error"]["message"]);
  //     }
  //
  //     print("jsonResponse $jsonResponse");
  //   } catch (error) {
  //     print("error $error");
  //   }
  // }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      // "text-davinci-003"
      var response = await http.post(
          Uri.parse("$BASE_URL/chat/completions"),
          headers: {
            "Authorization": "Bearer $API_KEY",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": modelId,
            "messages": [{"role": "user", "content": message}],
            // "prompt": message,
            "max_tokens": 2000,
          },
          )
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print(
            'jsonResponse["error"]["message"] ${jsonResponse["error"]["message"]}');
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // print('jsonResponse["choices"]text ${jsonResponse["choices"][0]["text"]}');
        chatList = List.generate(
            jsonResponse["choices"].length,
                (index) => ChatModel(
                    msg: jsonResponse["choices"][0]["message"]["content"],
                    chatIndex: 1,
                ),
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}