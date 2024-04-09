class StudentProfile {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  int userId;
  int techStackId;
  String resume;
  String transcript;
  TechStack techStack;
  List<Proposal> proposals;
  List<Education> educations;
  List<Language> languages;
  List<Experience> experiences;
  List<SkillSet> skillSets;

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
  });
}

class Education {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int studentId;
  String schoolName;
  DateTime startYear;
  DateTime endYear;

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
}

class Experience {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String deletedAt;
  int studentId;
  String title;
  String startMonth;
  String endMonth;
  String description;
  List<TechStack> skillSets;

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
}

class TechStack {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String? deletedAt;
  String name;

  TechStack({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
  });
}

class Language {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
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
  Student student;

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
    required this.student,
  });
}

class Student {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int userId;
  String fullname;
  int techStackId;
  dynamic resume;
  dynamic transcript;
  TechStack techStack;
  List<dynamic> educations;

  Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userId,
    required this.fullname,
    required this.techStackId,
    required this.resume,
    required this.transcript,
    required this.techStack,
    required this.educations,
  });
}

class SkillSet {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String? deletedAt;
  String name;

  SkillSet({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
  });
}
