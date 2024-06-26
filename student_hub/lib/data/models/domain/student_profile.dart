import 'dart:ffi';

import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';

class StudentProfile {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  int userId;
  int techStackId;
  String? resume;
  String? transcript;
  TechStack techStack;
  List<Proposal> proposals;
  List<Education> educations;
  List<Language> languages;
  List<Experience> experiences;
  List<SkillSet> skillSets;
  User? user;

  StudentProfile({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userId,
    required this.techStackId,
    required this.resume,
    required this.transcript,
    required this.techStack,
    required this.proposals,
    required this.educations,
    required this.languages,
    required this.experiences,
    required this.skillSets,
    required this.user
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'userId': this.userId,
      'techStackId': this.techStackId,
      'resume': this.resume,
      'transcript': this.transcript,
      'techStack': this.techStack.toMap(),
      'proposals': this.proposals?.map((e) => e.toJson()).toList(),
      'educations': this.educations?.map((e) => e.toMap()).toList(),
      'languages': this.languages?.map((e) => e.toMap()).toList(),
      'experiences': this.experiences?.map((e) => e.toMap()).toList(),
      'skillSets': this.skillSets?.map((e) => e.toMap()).toList(),
      'user': this.user == null ? null : this.user
    };
  }

  factory StudentProfile.fromMap(Map<String, dynamic> map) {
    print(map);
    return StudentProfile(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      userId: map['userId'] as int,
      techStackId: map['techStackId'] as int,
      resume: map['resume'] == null ? null : map['resume'] as String,
      transcript:
          map['transcript'] == null ? null : map['transcript'] as String,
      techStack: TechStack.fromMap(map['techStack']),
      proposals: map['proposals'] == null
          ? []
          : List.from(map['proposals'])
              .map((e) => Proposal.fromJson(e))
              .toList(),
      educations: map['educations'] == null
          ? []
          : List.from(map['educations'])
              .map((e) => Education.fromMap(e))
              .toList(),
      languages: map['languages'] == null
          ? []
          : List.from(map['languages'])
              .map((e) => Language.fromMap(e))
              .toList(),
      experiences: map['experiences'] == null
          ? []
          : List.from(map['experiences'])
              .map((e) => Experience.fromMap(e))
              .toList(),
      skillSets: map['skillSets'] == null
          ? []
          : List.from(map['skillSets'])
              .map((e) => SkillSet.fromMap(e))
              .toList(),
      user: map['user'] == null ? null : User.fromMap(map['user']) 
    );
  }
}

class TechStack {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String name;

  TechStack({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'name': this.name,
    };
  }

  factory TechStack.fromMap(Map<String, dynamic> map) {
    return TechStack(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      name: map['name'] as String,
    );
  }
}

class Education {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  int studentId;
  String schoolName;
  int startYear;
  int endYear;

  Education({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.studentId,
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'studentId': this.studentId,
      'schoolName': this.schoolName,
      'startYear': this.startYear,
      'endYear': this.endYear,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      studentId: map['studentId'] as int,
      schoolName: map['schoolName'] as String,
      startYear: map['startYear'] as int,
      endYear: map['endYear'] as int,
    );
  }
}

class Language {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  int studentId;
  String languageName;
  String level;

  Language({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.studentId,
    required this.languageName,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'studentId': this.studentId,
      'languageName': this.languageName,
      'level': this.level,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      studentId: map['studentId'] as int,
      languageName: map['languageName'] as String,
      level: map['level'] as String,
    );
  }
}

class Experience {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  int studentId;
  String title;
  String startMonth;
  String endMonth;
  String description;
  List<SkillSet> skillSets;

  Experience({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.studentId,
    required this.title,
    required this.startMonth,
    required this.endMonth,
    required this.description,
    required this.skillSets,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'studentId': this.studentId,
      'title': this.title,
      'startMonth': this.startMonth,
      'endMonth': this.endMonth,
      'description': this.description,
      'skillSets': this.skillSets.map((e) => e.toMap()).toList(),
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      studentId: map['studentId'] as int,
      title: map['title'] as String,
      startMonth: map['startMonth'] as String,
      endMonth: map['endMonth'] as String,
      description: map['description'] as String,
      skillSets:
          List.from(map['skillSets']).map((e) => SkillSet.fromMap(e)).toList(),
    );
  }
}

class SkillSet {
  int id;
  String createdAt;
  String updatedAt;
  String? deletedAt;
  String name;

  SkillSet({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'name': this.name,
    };
  }

  factory SkillSet.fromMap(Map<String, dynamic> map) {
    return SkillSet(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      deletedAt: map['deletedAt'] == null ? null : map['deletedAt'] as String,
      name: map['name'] as String,
    );
  }
}
