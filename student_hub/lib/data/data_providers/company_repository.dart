import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  Future<CompanyProfile?> getCompanyProfile(int id) async {
    final response = await http
        .get(Uri.parse('${Constants.apiBaseURL}/api/profile/company/$id'));

    if (response.statusCode == 200) {
      return CompanyProfile.fromJson(jsonDecode(response.body) as String);
    } else {
      throw Exception('[FAIL - NETWORK]Get company profile');
    }
  }

  Future<Object?> updateCompanyProfile(CompanyProfile companyProfile) async {
    final response =
        await http.post(Uri.parse('${Constants.apiBaseURL}/api/profile/company'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: companyProfile.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }
}
