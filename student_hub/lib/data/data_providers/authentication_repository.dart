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
  late String token;
  late final String? _email;
  late final String? _password;

  AuthenticationRepository() {
    SharedPreferences.getInstance()
        .then((prefs) {
          _email = prefs.getString(Constants.savedEmail);
          _password = prefs.getString(Constants.savedPassword);

          return prefs.getString(Constants.chosenUserRole);
        })
        .then((value) => UserRole.values.firstWhere(
              (element) => element.name == value,
              orElse: () => UserRole.student,
            ))
        .then((value) {
          currentUserRole = value;
          tryAutoLogIn();
        });
  }

  Stream<AuthenticationStatus> get authenticationStatus async* {
    yield* _authenticationStatusController.stream;
  }

  Future<void> tryAutoLogIn() async {
    try {
      if (_email == null || _password == null) {
        _authenticationStatusController
            .add(AuthenticationStatus.unauthenticated);
        throw Exception("Login information not found!");
      }

      final Uri uri = Uri.https(Constants.apiBaseURL, 'api/auth/sign-in');
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "email": _email,
            "password": _password,
          },
        ),
      );

      if (response.statusCode == 201) {
        token = json.decode(response.body)["result"]["token"];
        _authenticationStatusController.add(AuthenticationStatus.authenticated);
      } else if (response.statusCode == 422) {
        throw Exception(json.decode(response.body)['errorDetails']);
      } else {
        throw Exception(json.decode(response.body)['errorDetails']);
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<void> logIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      // doing register with backend
      final Uri uri = Uri.https(Constants.apiBaseURL, 'api/auth/sign-in');
      final response = await http.post(
        uri,
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
        token = json.decode(response.body)["result"]["token"];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.savedEmail, emailAddress);
        await prefs.setString(Constants.savedPassword, password);

        _authenticationStatusController.add(AuthenticationStatus.authenticated);
      } else if (response.statusCode == 422) {
        throw Exception(json.decode(response.body)['errorDetails']);
      } else {
        throw Exception(json.decode(response.body)['errorDetails']);
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<void> logOut() async {
    final Uri uri = Uri.https(Constants.apiBaseURL, '/api/auth/logout');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
      print("LOGGED OUT!!!!");
    } else {
      throw Exception('[FAIL - NETWORK] Logout');
    }
  }

  Future<void> signUp(
      {required String username,
      required String emailAddress,
      required String password,
      required UserRole userRole}) async {
    try {
      // doing register with backend
      final Uri uri = Uri.https(Constants.apiBaseURL, 'api/auth/sign-up');
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "email": emailAddress,
            "fullname": username,
            "password": password,
            "role": switch (userRole) {
              UserRole.student => 0,
              UserRole.company => 1,
            },
          },
        ),
      );
      print("STATUSCODE: " + response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 201) {
        currentUserRole = userRole;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(Constants.chosenUserRole, userRole.name);
      } else if (response.statusCode == 400) {
        throw Exception(json.decode(response.body)["errorDetails"]);
      } else {
        throw Exception(json.decode(response.body)["errorDetails"]);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void dispose() => _authenticationStatusController.close();
}
