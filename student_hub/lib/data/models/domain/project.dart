import 'dart:convert';

import 'package:student_hub/common/enums.dart';

class Project {
  int projectId;
  String createdAt;
  String? updatedAt;
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag.index,
      'title': title,
      'description': description,
      'numberOfStudents': numberOfStudents,
      'typeFlag': typeFlag,
      'countProposals': countProposals,
      'isFavorite': isFavorite,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['projectScopeFlag'] = projectScopeFlag.index;
    data['title'] = title;
    data['numberOfStudents'] = numberOfStudents;
    data['description'] = description;
    return data;
  }

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);
}
