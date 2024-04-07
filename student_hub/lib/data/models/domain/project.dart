// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Project {
  String companyId;
  String createdAt;
  String jobTitle;
  String jobDescription;
  int numberOfStudents;
  int numberOfProposals;
  int projectDuration;

  Project({
    required this.companyId,
    required this.createdAt,
    required this.jobTitle,
    required this.jobDescription,
    required this.numberOfStudents,
    required this.numberOfProposals,
    required this.projectDuration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'createdAt': createdAt,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'numberOfStudents': numberOfStudents,
      'numberOfProposals': numberOfProposals,
      'projectDuration': projectDuration,
      'typeFlag' : 0
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      companyId: map['companyId'] as String,
      createdAt: map['createdAt'] as String,
      jobTitle: map['jobTitle'] as String,
      jobDescription: map['jobDescription'] as String,
      numberOfStudents: map['numberOfStudents'] as int,
      numberOfProposals: map['numberOfProposals'] as int,
      projectDuration: map['projectDuration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);
}
