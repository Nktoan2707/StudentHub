import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:http/http.dart' as http;

class ProjectRepository {
  Future<List<Project>> getListProject(User user, String filterQuery) async {
    final response = await http.get(
      Uri.parse('${Constants.apiBaseURL}/api/project${filterQuery}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': user.token
      },
    );

    if (response.statusCode == 200) {
      //Need to convert to project List
      return [Project.fromJson(jsonDecode(response.body))];
    } else {
      throw Exception('[FAIL - NETWORK]Get list project');
    }
  }

  Future<Object?> createProject(User user, Project project) async {
    final response = await http.post(
        Uri.parse('${Constants.apiBaseURL}/api/project'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': user.token
        },
        body: project.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }

  Future<Project> getProjectDetail(User user, int id) async {
    final response = await http.post(
       Uri.parse('${Constants.apiBaseURL}/api/project/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': user.token
        });

    if (response.statusCode == 200) {
      return Project.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('[FAIL - NETWORK]Create company profile');
    }
  }
}
