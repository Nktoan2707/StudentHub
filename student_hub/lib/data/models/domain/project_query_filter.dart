import 'dart:convert';

import 'package:student_hub/common/enums.dart';

class ProjectQueryFilter {
  final ProjectScopeFlag projectScopeFlag;
  final int numberOfStudents;
  final int proposalsLessThan;

  ProjectQueryFilter(
      {required this.projectScopeFlag,
      required this.numberOfStudents,
      required this.proposalsLessThan});

  Map<String, dynamic> toMap() {
    return {
      'projectScopeFlag': this.projectScopeFlag,
      'numberOfStudents': this.numberOfStudents,
      'proposalsLessThan': this.projectScopeFlag.index,
    };
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
