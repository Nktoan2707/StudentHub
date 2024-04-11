import 'package:student_hub/common/enums.dart';

class ProjectQueryFilter {
  final String? title;
  final ProjectScopeFlag? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};
    if (title != null) {
      result.addEntries([MapEntry("title", title)]);
    }

    if (projectScopeFlag != null) {
      result.addEntries(
          [MapEntry("projectScopeFlag", projectScopeFlag!.index.toString())]);
    }
    if (numberOfStudents != null) {
      result.addEntries(
          [MapEntry("numberOfStudents", numberOfStudents.toString())]);
    }
    if (proposalsLessThan != null) {
      result.addEntries(
          [MapEntry("proposalsLessThan", proposalsLessThan.toString())]);
    }
    return result;
  }

  ProjectQueryFilter({
    this.title,
    this.projectScopeFlag,
    this.numberOfStudents,
    this.proposalsLessThan,
  });

  factory ProjectQueryFilter.fromMap(Map<String, dynamic> map) {
    return ProjectQueryFilter(
      title: map['title'] == null ? null : map['title'] as String,
      projectScopeFlag: map['projectScopeFlag'] == null
          ? null
          : map['projectScopeFlag'] as ProjectScopeFlag,
      numberOfStudents: map['numberOfStudents'] == null
          ? null
          : map['numberOfStudents'] as int,
      proposalsLessThan: map['proposalsLessThan'] == null
          ? null
          : map['proposalsLessThan'] as int,
    );
  }

// String toJson() => json.encode(toMap());

// factory ProjectQueryFilter.fromJson(String source) => ProjectQueryFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
