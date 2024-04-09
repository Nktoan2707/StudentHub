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
      'techStack': this.techStack,
      'proposals': this.proposals,
      'educations': this.educations,
      'languages': this.languages,
      'experiences': this.experiences,
      'skillSets': this.skillSets,
    };
  }

  factory StudentProfile.fromMap(Map<String, dynamic> map) {
    return StudentProfile(
      id: map['id'] as int,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as String,
      userId: map['userId'] as int,
      techStackId: map['techStackId'] as int,
      resume: map['resume'] as String,
      transcript: map['transcript'] as String,
      techStack: map['techStack'] as TechStack,
      proposals: map['proposals'] as List<Proposal>,
      educations: map['educations'] as List<Education>,
      languages: map['languages'] as List<Language>,
      experiences: map['experiences'] as List<Experience>,
      skillSets: map['skillSets'] as List<SkillSet>,
    );
  }
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
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as dynamic,
      studentId: map['studentId'] as int,
      schoolName: map['schoolName'] as String,
      startYear: map['startYear'] as DateTime,
      endYear: map['endYear'] as DateTime,
    );
  }
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
      'skillSets': this.skillSets,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      id: map['id'] as int,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as String,
      studentId: map['studentId'] as int,
      title: map['title'] as String,
      startMonth: map['startMonth'] as String,
      endMonth: map['endMonth'] as String,
      description: map['description'] as String,
      skillSets: map['skillSets'] as List<TechStack>,
    );
  }
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
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as String,
      name: map['name'] as String,
    );
  }
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
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as dynamic,
      studentId: map['studentId'] as int,
      languageName: map['languageName'] as String,
      level: map['level'] as String,
    );
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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'projectId': this.projectId,
      'studentId': this.studentId,
      'coverLetter': this.coverLetter,
      'statusFlag': this.statusFlag,
      'disableFlag': this.disableFlag,
      'student': this.student,
    };
  }

  factory Proposal.fromMap(Map<String, dynamic> map) {
    return Proposal(
      id: map['id'] as int,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as dynamic,
      projectId: map['projectId'] as int,
      studentId: map['studentId'] as int,
      coverLetter: map['coverLetter'] as String,
      statusFlag: map['statusFlag'] as int,
      disableFlag: map['disableFlag'] as int,
      student: map['student'] as Student,
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'deletedAt': this.deletedAt,
      'userId': this.userId,
      'fullname': this.fullname,
      'techStackId': this.techStackId,
      'resume': this.resume,
      'transcript': this.transcript,
      'techStack': this.techStack,
      'educations': this.educations,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as dynamic,
      userId: map['userId'] as int,
      fullname: map['fullname'] as String,
      techStackId: map['techStackId'] as int,
      resume: map['resume'] as dynamic,
      transcript: map['transcript'] as dynamic,
      techStack: map['techStack'] as TechStack,
      educations: map['educations'] as List<dynamic>,
    );
  }
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
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
      deletedAt: map['deletedAt'] as String,
      name: map['name'] as String,
    );
  }
}
