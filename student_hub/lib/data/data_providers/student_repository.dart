import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  // StudentProfile? _studentProfile;
  // bool doesNeedUpdate = true;

  // Future<StudentProfile> getStudentProfileById(
  //     {required String token, required int studentId}) async {
  //   // if (!doesNeedUpdate) {
  //   //   return _currentUser;
  //   // }
  //
  //   final Uri uri = Uri.https(Constants.apiBaseURL, '/api/profile/student/$id');
  //   final response = await http.get(
  //     uri,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     doesNeedUpdate = false;
  //     print("[GET-User] Inprogress");
  //     User user = User.fromMap(json.decode(response.body)["result"]);
  //     print("[GET-User] Success");
  //     _currentUser = user;
  //     return _currentUser;
  //   } else {
  //     throw Exception('[FAIL - NETWORK] UserRepository.getCurrentUser');
  //   }
  // }

  //If user not have student profile then create an empty one using this method
  Future<void> postStudentProfile({required String token}) async {
    try {
      final Uri uri = Uri.https(Constants.apiBaseURL, '/api/profile/student');
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: {"techStackId": 1, "skillSets": []},
      );
      print(response.body);
      if (response.statusCode == 201) {
        print("[Post-StudentProfile] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfile(
      {required String token,
      required int studentId,
      required StudentProfile studentProfile}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/profile/student/${studentId}');
      final response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(studentProfile.toMap()),
      );

      print(studentProfile.toMap());

      print(response.body);
      if (response.statusCode == 200) {
        print("[Post-StudentProfile] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TechStack>> getAllTechStack() async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/techstack/getAllTechStack');
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        // print("[getAllTechStack-StudentProfile] Success");
        final List<TechStack> result =
            List.from(jsonDecode(response.body)["result"])
                .map((e) => TechStack.fromMap(e))
                .toList();

        return result;
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SkillSet>> getAllSkillSet() async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/skillset/getAllSkillSet');
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        // print("[getAllTechStack-StudentProfile] Success");
        final List<SkillSet> result =
            List.from(jsonDecode(response.body)["result"])
                .map((e) => SkillSet.fromMap(e))
                .toList();

        return result;
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
