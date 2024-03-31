import 'dart:convert';
import 'dart:ffi';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/company.dart';
import 'package:http/http.dart' as http;

class CompanyRepository {
  Future<Company?> getCompanyProfile(int id) async {
    final response = await http
        .get(Uri.parse('${Constant.apiBaseURL}/api/profile/company/$id'));

    if (response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body) as String);
    } else {
      throw Exception('[FAIL - NETWORK]Get company profile');
    }
  }

  Future<Object?> updateCompanyProfile(Company companyProfile) async {
    final response =
        await http.post(Uri.parse('${Constant.apiBaseURL}/api/profile/company'),
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
