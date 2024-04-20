import 'dart:convert';

import 'package:student_hub/common/enums.dart';

class Project {
  int? projectId;
  late String createdAt;
  String? updatedAt;
  String? deletedAt;
  late String companyId;
  late ProjectScopeFlag projectScopeFlag;
  late String title;
  late String description;
  late int numberOfStudents;
  int? typeFlag;
  late int countProposals;
  late bool isFavorite;
  int? countMessages;
  int? countHired;
  List<Proposal>? proposals;

  Project(
      {required this.projectId,
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
      required this.countHired,
      required this.countMessages});

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
      'countHired': countHired,
      'countMessages': countMessages,
      'proposals': proposals
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
        projectId: map['id'] == null ? null : map['id'] as int,
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
        isFavorite:
            map['isFavorite'] == null ? false : map['isFavorite'] as bool,
        countHired: map['countHired'] == null ? null : map['countHired'] as int,
        countMessages:
            map['countMessages'] == null ? null : map['countMessages'] as int);
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

  Project.fromJson(Map<String, dynamic> json) {
    projectId = json['id'];
    createdAt = json['createdAt'] as String;
    updatedAt = json['updatedAt'] == null ? null : json['updatedAt'] as String;
    deletedAt = json['deletedAt'] == null ? null : json['deletedAt'] as String;
    companyId = json['companyId'] as String;
    projectScopeFlag =
        ProjectScopeFlag.values[(json['projectScopeFlag'] as int)];
    title = json['title'] as String;
    description = json['description'] as String;
    numberOfStudents = json['numberOfStudents'] as int;
    typeFlag = json['typeFlag'] == null ? null : json['typeFlag'] as int;
    countProposals = json['countProposals'] as int;
    isFavorite =
        json['isFavorite'] == null ? false : json['isFavorite'] as bool;
    countHired = json['countHired'] == null ? null : json['countHired'] as int;
    countMessages =
        json['countMessages'] == null ? null : json['countMessages'] as int;
        proposals =  json['proposals'] == null ? null : List.from(json['proposals'])
            .map((e) => Proposal.fromJson(e))
            .toList();
  }
}

class Proposal {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int projectId;
  int studentId;
  String coverLetter;
  int statusFlag;
  int disableFlag;

  Proposal({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        projectId: json["projectId"],
        studentId: json["studentId"],
        coverLetter: json["coverLetter"],
        statusFlag: json["statusFlag"],
        disableFlag: json["disableFlag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt,
        "projectId": projectId,
        "studentId": studentId,
        "coverLetter": coverLetter,
        "statusFlag": statusFlag,
        "disableFlag": disableFlag,
      };
}
