
import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/data/models/domain/student_profile.dart';
import 'package:uuid/uuid.dart';

class StudentRepository {
  StudentProfile? _student;

  Future<StudentProfile?> getStudentProfile(int id) async {
    final response = await http
        .get(Uri.parse('${Constants.apiBaseURL}/api/profile/student/$id'));

    if (response.statusCode == 200) {
      return StudentProfile.fromJson(jsonDecode(response.body) as String);
    } else {
      throw Exception('[FAIL - NETWORK]Get student profile');
    }
  }

  Future<Object?> updateStudentProfile(StudentProfile studentProfile) async {
    final response =
        await http.post(Uri.parse('${Constants.apiBaseURL}/api/profile/student'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: studentProfile.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update student profile');
    }
  }
}
