import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:http/http.dart' as http;

class ProjectRepository {
  Future<List<Project>> getListProject(
      {required User user,
      required ProjectQueryFilter filterQuery,
      required String token}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/project', filterQuery.toMap());

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return List.from(jsonDecode(response.body)['result'])
            .map((e) => Project.fromMap(e))
            .toList();
      } else {
        throw Exception('[FAIL - NETWORK]Get list project');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Object?> createProject(
      {required User user,
      required Project project,
      required String token}) async {
    final Uri uri = Uri.https(Constants.apiBaseURL, '/api/project');
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(project.toJson()));

    print("[NETWORK-CREATE PROJECT] project ${jsonEncode(project.toJson())}");

    print("[NETWORK-CREATE PROJECT] statusCode${response.statusCode}");
    print("[NETWORK-CREATE PROJECT] body${response.body}");

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Post Project');
    }
  }

  Future<void> patchStudentFavoriteProject(
      {required User user,
      required int projectId,
      required bool isDisabled,
      required String token}) async {
    final Uri uri = Uri.https(
        Constants.apiBaseURL, 'api/favoriteProject/${user.studentProfile!.id}');
    final response = await http.patch(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
          {"projectId": projectId, "disableFlag": isDisabled ? 1 : 0}),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }

  Future<Project?> getProjectDetail(
      {required int projectId,
      required String token}) async {
    try {
      Uri uri;
      uri = Uri.https(Constants.apiBaseURL,
            '/api/project/$projectId');

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(
          "[NETWORK-GET PROJECT DETAIL] statusCode${response.statusCode}");
      print("[NETWORK-GET PROJECT DETAIL] body${response.body}");

      if (response.statusCode == 200) {
        return Project.fromJson(jsonDecode(response.body)['result']);
      } else {
        throw Exception('[FAIL - NETWORK]Get project detail');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Project>?> getListCompanyProject(
      {required User user,
      required int typeFlag,
      required String token}) async {
    try {
      Uri uri;
      if (typeFlag == -1) {
        uri = Uri.https(Constants.apiBaseURL,
            '/api/project/company/${user.companyProfile!.id}');
      } else {
        uri = Uri.https(Constants.apiBaseURL,
            '/api/project/company/${user.companyProfile!.id}?typeFlag=$typeFlag');
      }

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(
          "[NETWORK-GET LIST COMPANY PROJECT] statusCode${response.statusCode}");
      print("[NETWORK-GET LIST COMPANY PROJECT] body${response.body}");

      if (response.statusCode == 200) {
        return List.from(jsonDecode(response.body)['result'])
            .map((e) => Project.fromMap(e))
            .toList();
      } else {
        if (response.statusCode == 404) {
          return List.empty();
        } else {
          throw Exception('[FAIL - NETWORK]Get list project');
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
