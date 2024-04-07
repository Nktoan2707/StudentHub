import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/data/models/domain/user.dart';

class CompanyRepository {

  // id = companyId
  Future<CompanyProfile?> getCompanyProfile(User user) async {
    final response = await http
        .get(Uri.parse('${Constants.apiBaseURL}/api/profile/company/${user.companyProfile?.companyId}'));

    if (response.statusCode == 200) {
      return CompanyProfile.fromJson(jsonDecode(response.body) as String);
    } else {
      throw Exception('[FAIL - NETWORK]Get company profile');
    }
  }

  Future<Object?> updateCompanyProfile(User user) async {
    final response =
        await http.put(Uri.parse('${Constants.apiBaseURL}/api/profile/company/${user.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': user.token
            },
            body: user.companyProfile!.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }

  Future<Object?> createCompanyProfile(User user) async {
    final response =
        await http.post(Uri.parse('${Constants.apiBaseURL}/api/profile/company'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': user.token
            },
            body: user.companyProfile!.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Create company profile');
    }
  }
}
