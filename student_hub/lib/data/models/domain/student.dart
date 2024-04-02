
import 'package:student_hub/data/models/domain/user.dart';

import 'dart:convert';

import 'package:equatable/equatable.dart';

class StudentProfile extends Equatable {
  final TechStack techStack;
  final List<SkillSet> skillSet;
  final List<String> language;
  final List<Education> education;
  final Transcript transcript;
  final Resume resume;

  @override
  List<Object?> get props => [
        techStack,
        skillSet,
        language,
        education,
        transcript,
        resume,
      ];

  const StudentProfile({
    required this.techStack,
    required this.skillSet,
    required this.language,
    required this.education,
    required this.transcript,
    required this.resume,
  });
}

class SkillSet {
  final String id;
  final String name;

  SkillSet({required this.id, required this.name});
}

class TechStack {
  final String id;
  final String name;

  TechStack({required this.id, required this.name});
}

class Language {
  final String id;
  final String studentId;
  final String languageName;
  final String level;

  Language({
    required this.id,
    required this.studentId,
    required this.languageName,
    required this.level,
  });
}

class Education {
  final String id;
  final String studentId;
  final String schoolName;
  final DateTime startYear;
  final DateTime endYear;

  Education({
    required this.id,
    required this.studentId,
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });
}

class Experience {
  final String id;
  final String studentId;
  final String title;
  final DateTime startMonth;
  final DateTime endMonth;
  final String description;

  Experience({
    required this.id,
    required this.studentId,
    required this.title,
    required this.startMonth,
    required this.endMonth,
    required this.description,
  });
}

class Transcript {
  // Define your transcript properties here
}

class Resume {
  // Define your resume properties here
}
