import 'dart:convert';

import 'package:student_hub/common/enums.dart';

class Project {
  int projectId;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String companyId;
  ProjectScopeFlag projectScopeFlag;
  String title;
  String description;
  int numberOfStudents;
  int? typeFlag;
  int countProposals;
  bool isFavorite;

  Project({
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.companyId,
    required this.projectScopeFlag,
    required this.title,
    required this.description,
    required this.numberOfStudents,
    required this.typeFlag,
    required this.countProposals,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'projectId': this.projectId,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'companyId': this.companyId,
      'projectScopeFlag': this.projectScopeFlag,
      'title': this.title,
      'description': this.description,
      'numberOfStudents': this.numberOfStudents,
      'typeFlag': this.typeFlag,
      'countProposals': this.countProposals,
      'isFavorite': this.isFavorite,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      projectId: map['projectId'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      companyId: map['companyId'] as String,
      projectScopeFlag:
          ProjectScopeFlag.values[(map['projectScopeFlag'] as int)],
      title: map['title'] as String,
      description: map['description'] as String,
      numberOfStudents: map['numberOfStudents'] as int,
      typeFlag: map['typeFlag'] == null ? null : map['typeFlag'] as int,
      countProposals: map['countProposals'] as int,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);
}
