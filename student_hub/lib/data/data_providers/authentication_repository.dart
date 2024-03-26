import 'dart:async';

import 'package:student_hub/common/enums.dart';

class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _authenticationStatusController =
      StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get authenticationStatus async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _authenticationStatusController.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // throw Exception("login failed");
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _authenticationStatusController
          .add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    //thuc hien log out voi backend

    //
    _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
  }

  Future<void> signUp() async {
    throw Exception("register failed");

    // doing register with backend
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }

  void dispose() => _authenticationStatusController.close();
}
