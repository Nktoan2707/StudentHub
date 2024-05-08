import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/message_detail.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/data/models/domain/user.dart';

class MessageRepository {
  Future<List<MessageContent>> getListMessageOfProject(
      {required int projectId, required String token, required User user}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/message');

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('[NETWORK]Get List Message ProjectID:$projectId body: ${response.body}');
      print(response.statusCode);
      
      List listMessageJson = jsonDecode(response.body)['result'];
      List<MessageContent> listMessageContent = [];
      listMessageJson.forEach((element) {
        element["me"] = user;
        listMessageContent.add(MessageContent.fromJson(element));
      });

      if (response.statusCode == 200) {
        return listMessageContent;
      } else {
        throw Exception('[FAIL - NETWORK]Get message project: $projectId');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> sendMessage(
      {required MessageSent messageSent, required String token}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/message/sendMessage');

      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(messageSent.toJson())
      );

      print('[NETWORK]Sent Message ${messageSent.toJson()}');
      print(response.statusCode);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('[FAIL - NETWORK]Sent Message Fail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MessageContent>> getListMessageOfUser(
      {required int projectId, required String token, required int userid, required User me}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/message/${projectId}/user/$userid');

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('[NETWORK]Get List Message of User ProjectID:$projectId User:$userid ${response.body}');
      print(response.statusCode);
      
      List listMessageJson = jsonDecode(response.body)['result'];
      List<MessageContent> listMessageContent = [];
      listMessageJson.forEach((element) {
        element["me"] = me;
        listMessageContent.add(MessageContent.fromJson(element));
      });
      if (response.statusCode == 200) {
        return listMessageContent;
      } else {
        throw Exception('[FAIL - NETWORK]Get message of user: $userid');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MessageContent>> getListMessageOfMe(
      {required String token, required User me}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/message');

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print('[NETWORK]Get List Message of ME ${response.body}');
      print(response.statusCode);
      
      List listMessageJson = jsonDecode(response.body)['result'];
      List<MessageContent> listMessageContent = [];
      listMessageJson.forEach((element) {
        element["me"] = me;
        listMessageContent.add(MessageContent.fromJson(element));
      });
      if (response.statusCode == 200) {
        return listMessageContent;
      } else {
        throw Exception('[FAIL - NETWORK]Get message of ME');
      }
    } catch (e) {
      rethrow;
    }
  }
}
