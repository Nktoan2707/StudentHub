import 'dart:async';
import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  late User _currentUser;
  bool doesNeedUpdate = true;

  Future<User> getCurrentUser(String token) async {
    // if (!doesNeedUpdate) {
    //   return _currentUser;
    // }

    final Uri uri = Uri.https(Constants.apiBaseURL, '/api/auth/me');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      doesNeedUpdate = false;
      User user = User.fromMap(json.decode(response.body)["result"]);
      _currentUser = user;
      return _currentUser;
    } else {
      throw Exception('[FAIL - NETWORK] UserRepository.getCurrentUser');
    }
  }
}
