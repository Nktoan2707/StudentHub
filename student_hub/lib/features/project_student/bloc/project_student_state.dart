part of 'project_student_bloc.dart';

abstract class ProjectStudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectStudentInitial extends ProjectStudentState {}

class ProjectStudentFetchInProgress extends ProjectStudentState {
  @override
  String toString() => "ProjectStudentFetchInProgress {  }";
}

class ProjectStudentFetchSuccess extends ProjectStudentState {
  final List<Project> projectList;
  final List<Project> favoriteProjectList;

  ProjectStudentFetchSuccess(
      {required this.projectList, required this.favoriteProjectList});

  @override
  List<Object?> get props => [projectList, favoriteProjectList];

  @override
  String toString() =>
      "ProjectStudentFetchSuccess { projectList: $projectList, favoriteProjectList: $favoriteProjectList }";
}
