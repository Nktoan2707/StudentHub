import 'dart:convert';

import 'package:intl/number_symbols.dart';
import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:http/http.dart' as http;
import 'package:student_hub/data/models/domain/user.dart';

class CompanyRepository {
  // id = companyId
  Future<CompanyProfile?> getCompanyProfile(
      {required User user, required String token}) async {
    final Uri uri =
        Uri.https(Constants.apiBaseURL, 'api/profile/company/${user.companyProfile?.id}');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return CompanyProfile.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      return null;
    } else {
      throw Exception('[FAIL - NETWORK]Get company profile');
    }
  }

  Future<Object?> updateCompanyProfile(
      {required CompanyProfile companyProfile, required String token}) async {
    final Uri uri = Uri.https(
        Constants.apiBaseURL, '/api/profile/company/${companyProfile.id}');
    final response = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(companyProfile.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Update company profile');
    }
  }

  Future<Object?> createCompanyProfile(
      {required CompanyProfile companyProfile, required String token}) async {
    final Uri uri = Uri.https(Constants.apiBaseURL, 'api/profile/company');
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(companyProfile.toJson()));

    print('[NETWORK]Create company profile${response.body}');
    print (response.statusCode);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('[FAIL - NETWORK]Create company profile');
    }
  }
}
