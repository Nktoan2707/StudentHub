import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/data/models/domain/notification_detail.dart';
import 'package:student_hub/data/models/domain/user.dart';

class NotificationRepository {
  Future<List<NotificationDetail>> getNotificationListByUserId({
    required String token,
    required User user,
  }) async {
    try {
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/notification/getByReceiverId/${user.id}');
      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      // print(uri);
      // print(response.body);
      // print("$token ------- $userId");

      if (response.statusCode == 200) {
        final List<NotificationDetail> result =
            List.from(jsonDecode(response.body)["result"])
                .map((e) => NotificationDetail.fromJson(e))
                .toList();

        result.sort((a, b) {
          return a.createdAt.millisecondsSinceEpoch <=
                  b.createdAt.millisecondsSinceEpoch
              ? 1
              : 0;
        });

        return result;
      } else if (response.statusCode == 500) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markReadNotificationById(
      {required int notificationId, required String token}) async {
    final Uri uri = Uri.https(
        Constants.apiBaseURL, '/api/notification/readNoti/$notificationId');
    final response = await http.patch(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print("[markReadNotificationById] statusCode${response.statusCode}");
    print("[markReadNotificationById] body${response.body}");

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('[markReadNotificationById] Failed');
    }
  }
}
