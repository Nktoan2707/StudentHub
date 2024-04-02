import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/common/constants.dart';
import 'package:student_hub/common/enums.dart';

import 'package:http/http.dart' as http;

class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _authenticationStatusController =
      StreamController<AuthenticationStatus>();

  UserRole currentUserRole = UserRole.student;

  AuthenticationRepository() {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.getString(Constants.chosenUserRole))
        .then((value) => UserRole.values.firstWhere(
              (element) => element.name == value,
              orElse: () => UserRole.student,
            ))
        .then((value) => currentUserRole = value);
  }

  Stream<AuthenticationStatus> get authenticationStatus async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _authenticationStatusController.stream;
  }

  Future<void> logIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      // doing register with backend
      final http.Response response = await http.post(
        Uri.parse('${Constants.apiBaseURL}/api/auth/sign-in'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "email": emailAddress,
            "password": password,
          },
        ),
      );

      if (response.statusCode == 201) {
        _authenticationStatusController.add(AuthenticationStatus.authenticated);
      } else if (response.statusCode == 422) {
        throw Exception(json.decode(response.body));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void logOut() {
    //thuc hien log out voi backend

    //
    _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> signUp(
      {required String username,
      required String emailAddress,
      required String password,
      required UserRole userRole}) async {
    try {
      // doing register with backend
      final http.Response response =
          await http.post(Uri.parse('${Constants.apiBaseURL}/api/auth/sign-up'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                "email": emailAddress,
                "fullname": username,
                "password": password,
                "role": switch (userRole) {
                  UserRole.student => 0,
                  UserRole.company => 1,
                },
              }));

      if (response.statusCode == 200) {
        currentUserRole = userRole;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.chosenUserRole, userRole.name);
      } else if (response.statusCode == 400) {
        throw Exception(json.decode(response.body)["errorDetails"]);
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  void dispose() => _authenticationStatusController.close();
}
