import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';

class User extends Equatable {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String token;
  final CompanyProfile? companyProfile;
  final StudentProfile? studentProfile;

  @override
  List<Object> get props => [id, email, password];

  // static const empty = User(id: '-', email: '-', password: '-');

  const User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.token,
    this.companyProfile,
    this.studentProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'token': token,
      'companyProfile': companyProfile,
      'studentProfile': studentProfile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      companyProfile: map['companyProfile'] as CompanyProfile,
      studentProfile: map['studentProfile'] as StudentProfile,
    );
  }
}
