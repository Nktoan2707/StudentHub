import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [id, email, password];

  static const empty = User(id: '-', email: '-', password: '-');

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'password': this.password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
