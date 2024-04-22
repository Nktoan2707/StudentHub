import 'dart:convert';
import 'dart:io';

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
      print(studentProfile.toMap());
      await putStudentProfileTechStackSkillSet(
          token: token, studentId: studentId, studentProfile: studentProfile);

      await putStudentProfileLanguages(
          token: token,
          studentId: studentId,
          listLanguage: studentProfile.languages);

      await putStudentProfileEducations(
          token: token,
          studentId: studentId,
          listEducation: studentProfile.educations);

      await putStudentProfileExperiences(
          token: token,
          studentId: studentId,
          listExperience: studentProfile.experiences);

      if (studentProfile.resume != null && studentProfile.resume!.isNotEmpty) {
        await putStudentProfileResume(
            token: token,
            studentId: studentId,
            resumeFilePath: studentProfile.resume!);

        if (studentProfile.transcript != null &&
            studentProfile.transcript!.isNotEmpty) {
          await putStudentProfileTranscript(
              token: token,
              studentId: studentId,
              transcriptFilePath: studentProfile.transcript!);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileTechStackSkillSet(
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
        body: json.encode({
          "techStackId": studentProfile.techStackId,
          "skillSets": studentProfile.skillSets.map((e) => e.id).toList(),
        }),
      );

      if (response.statusCode == 200) {
        print("[putStudentProfileTechStackSkillSet] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileLanguages(
      {required String token,
      required int studentId,
      required List<Language> listLanguage}) async {
    try {
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/language/updateByStudentId/${studentId}');
      final response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "languages": listLanguage
              .map((e) => {
                    "languageName": e.languageName,
                    "level": e.level,
                  })
              .toList(growable: false)
        }),
      );

      if (response.statusCode == 200) {
        print("[putStudentProfileLanguages] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileEducations(
      {required String token,
      required int studentId,
      required List<Education> listEducation}) async {
    try {
      final Uri uri = Uri.https(Constants.apiBaseURL,
          '/api/education/updateByStudentId/${studentId}');
      final response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "education": listEducation
              .map((e) => {
                    "schoolName": e.schoolName,
                    "startYear": e.startYear,
                    "endYear": e.endYear,
                  })
              .toList(growable: false)
        }),
      );

      if (response.statusCode == 200) {
        print("[putStudentProfileEducations] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileExperiences(
      {required String token,
      required int studentId,
      required List<Experience> listExperience}) async {
    try {
      final Uri uri = Uri.https(Constants.apiBaseURL,
          '/api/experience/updateByStudentId/${studentId}');
      final response = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "experience": listExperience
              .map((e) => {
                    "title": e.title,
                    "startMonth": e.startMonth,
                    "endMonth": e.endMonth,
                    "description": e.description,
                    "skillSets": e.skillSets.map((e) => e.toMap()).toList(),
                  })
              .toList(growable: false)
        }),
      );

      if (response.statusCode == 200) {
        print("[putStudentProfileExperiences] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getStudentProfileResumeUrl({
    required String token,
    required int studentId,
  }) async {
    try {
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/profile/student/${studentId}/resume');
      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("[getStudentProfileResumeUrl] Success");
        final String? result = jsonDecode(response.body)["result"];

        return result;
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileResume(
      {required String token,
      required int studentId,
      required String resumeFilePath}) async {
    try {
      // Prepare the request
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/profile/student/${studentId}/resume');
      http.MultipartRequest request = http.MultipartRequest(
        'PUT',
        uri,
      );

      // Add headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add file
      http.MultipartFile file = await http.MultipartFile.fromPath(
        'file',
        resumeFilePath,
      );
      request.files.add(file);

      // Send the request
      http.StreamedResponse response = await request.send();

      // Get the response body
      String responseBody = await response.stream.bytesToString();

      // Check the response status code
      if (response.statusCode == 200) {
        print("[putStudentProfileResume] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(responseBody)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromData(response.statusCode, responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getStudentProfileTranscriptUrl({
    required String token,
    required int studentId,
  }) async {
    try {
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/profile/student/${studentId}/transcript');
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("[getStudentProfileTranscriptUrl] Success");
        final String? result = jsonDecode(response.body)["result"];

        return result;
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> putStudentProfileTranscript(
      {required String token,
      required int studentId,
      required String transcriptFilePath}) async {
    try {
      // Prepare the request
      final Uri uri = Uri.https(
          Constants.apiBaseURL, '/api/profile/student/${studentId}/transcript');
      var request = http.MultipartRequest(
        'PUT',
        uri,
      );

      // Add headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add file
      var file = await http.MultipartFile.fromPath(
        'file',
        transcriptFilePath,
      );
      request.files.add(file);

      // Send the request
      var response = await request.send();

      // Get the response body
      var responseBody = await response.stream.bytesToString();

      // Check the response status code
      if (response.statusCode == 200) {
        print("[putStudentProfileTranscript] Success");
      } else if (response.statusCode == 422) {
        throw Exception(jsonDecode(responseBody)["errorDetails"]);
      } else {
        throw _getGeneralExceptionFromData(response.statusCode, responseBody);
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
        throw _getGeneralExceptionFromResponse(response);
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
        throw _getGeneralExceptionFromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  _getGeneralExceptionFromResponse(http.Response response) {
    return Exception(
        "${response.statusCode}: ${jsonDecode(response.body)["errorDetails"]}");
  }

  _getGeneralExceptionFromData(int statusCode, String responseBody) {
    return Exception(
        "${statusCode}: ${jsonDecode(responseBody)["errorDetails"]}");
  }
}
