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

    final Uri uri =
        Uri.https(Constants.apiBaseURL, '/api/project', filterQuery.toMap());

    print(uri);

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      //Need to convert to project List
      return [Project.fromJson(jsonDecode(response.body))];
    } else {
      throw Exception('[FAIL - NETWORK]Get list project');
    }
  }

  Future<Object?> createProject(
      {required User user,
      required Project project,
      required String token}) async {
    final Uri uri = Uri.https(Constants.apiBaseURL, 'api/project');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: project.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }

  Future<Project> getProjectDetail(
      {required User user, required int id, required String token}) async {
    final Uri uri = Uri.https(Constants.apiBaseURL, 'api/project/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Project.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('[FAIL - NETWORK]Create company profile');
    }
  }
}
