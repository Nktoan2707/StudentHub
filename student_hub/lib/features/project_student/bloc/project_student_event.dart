part of 'project_student_bloc.dart';

abstract class ProjectStudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectStudentFetched extends ProjectStudentEvent {
  @override
  String toString() => "ProjectStudentFetched {}";
}

class ProjectStudentUpdated extends ProjectStudentEvent {
  final int projectId;
  final bool isDisabled;
  final String? callerPageId;

  ProjectStudentUpdated({required this.projectId, required this.isDisabled, this.callerPageId});


  @override
  String toString() {
    return "ProjectStudentUpdated {}";
  }
}

class ProjectStudentSearched extends ProjectStudentEvent {
  final ProjectQueryFilter projectQueryFilter;

  ProjectStudentSearched({required this.projectQueryFilter});

  @override
  String toString() {
    return "ProjectStudentSearched {ProjectQueryFilter: $projectQueryFilter}";
  }
}
