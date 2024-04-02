// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:student_hub/data/models/domain/user.dart';

enum EmployeeQuantityType { onlyMe, small, medium, large, xlarge }

class CompanyProfile extends Equatable {
  String companyName;
  EmployeeQuantityType employeeQuantityType;
  String websiteName;
  String description;
  CompanyProfile({
    required this.companyName,
    required this.employeeQuantityType,
    required this.websiteName,
    required this.description,
  });
  
  @override
  List<Object> get props => [companyName, employeeQuantityType, websiteName, description];

  CompanyProfile copyWith({
    String? companyName,
    EmployeeQuantityType? employeeQuantityType,
    String? websiteName,
    String? description,
  }) {
    return CompanyProfile(
      companyName: companyName ?? this.companyName,
      employeeQuantityType: employeeQuantityType ?? this.employeeQuantityType,
      websiteName: websiteName ?? this.websiteName,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'size': employeeQuantityType.index,
      'website': websiteName,
      'description': description,
    };
  }

  factory CompanyProfile.fromMap(Map<String, dynamic> map) {
    int val = map['messageType'];
    return CompanyProfile(
      companyName: map['companyName'] as String,
      employeeQuantityType: EmployeeQuantityType.values[val],
      websiteName: map['website'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyProfile.fromJson(String source) => CompanyProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
 
}
