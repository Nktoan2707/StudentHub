
import 'dart:convert';

import 'package:student_hub/common/constants.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:http/http.dart' as http;
class ProposalRepository {
  Future<List<Proposal>> getListProposal(
      {required int projectId,
      required String token}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/proposal/getByProjectId/$projectId');

      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

       print(
          "[NETWORK-GET PROPOSAL LIST] statusCode${response.statusCode}");
      print("[NETWORK-GET PROPOSAL LIST] body${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return List.from(jsonDecode(response.body)['result']['items'])
            .map((e) => Proposal.fromJson(e))
            .toList();
      } else {
        throw Exception('[FAIL - NETWORK]Get list proposal');
      }
    } catch (e) {
      rethrow;
    }
  }

Future<bool> updateStatusProposal(
      {required Proposal proposal,
      required String token}) async {
    try {
      final Uri uri =
          Uri.https(Constants.apiBaseURL, '/api/proposal/${proposal.id}');

      final response = await http.patch(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(proposal.toJson()) 
      );

       print(
          "[NETWORK-GET PROPOSAL LIST] statusCode${response.statusCode}");
      print("[NETWORK-GET PROPOSAL LIST] body${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('[FAIL - NETWORK]Get list proposal');
      }
    } catch (e) {
      rethrow;
    }
  }

}