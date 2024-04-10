import 'package:student_hub/common/enums.dart';

class ProjectQueryFilter {
  final ProjectScopeFlag? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;

  ProjectQueryFilter(
      {this.projectScopeFlag, this.numberOfStudents, this.proposalsLessThan});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};
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

// factory ProjectQueryFilter.fromMap(Map<String, dynamic> map) {
//   return ProjectQueryFilter(
//     projectScopeFlag: map['projectScopeFlag'] as ProjectScopeFlag,
//     numberOfStudents: map['numberOfStudents'] as int,
//     proposalsLessThan: map['proposalsLessThan'] as int,
//   );
// }

// String toJson() => json.encode(toMap());

// factory ProjectQueryFilter.fromJson(String source) => ProjectQueryFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
