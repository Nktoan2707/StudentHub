import 'dart:async';

import 'package:student_hub/data/models/domain/user.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
          id: const Uuid().v4(),
          email: 'test@gmail.com',
          password: "testpassword",
          token: '',
          userName: ''),
    );
  }
}
