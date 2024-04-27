import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/data/models/domain/student_profile.dart';

class User extends Equatable {
  final int id;
  final String fullname;
  final List<int>? roles;
  final CompanyProfile? companyProfile;
  final StudentProfile? studentProfile;

  @override
  List<Object> get props => [];

  static const empty = User(
      fullname: '-',
      id: 0,
      companyProfile: null,
      roles: null,
      studentProfile: null);

  const User({
    required this.id,
    required this.fullname,
    this.roles,
    this.companyProfile,
    this.studentProfile,
  });

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'roles': roles,
      'companyProfile': companyProfile,
      'studentProfile': studentProfile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] == null ? 0 : map['id'] as int,
      fullname: map['fullname'] as String,
      roles:map['role'] == null ? [] : List<int>.from(map['roles']),
      companyProfile: map['company'] == null
          ? null
          : CompanyProfile.fromMap(map['company']),
      studentProfile: map['student'] == null
          ? null
          : StudentProfile.fromMap(map['student']),
    );
  }
}
