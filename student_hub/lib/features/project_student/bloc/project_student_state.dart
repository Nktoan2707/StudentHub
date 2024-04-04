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

  @override
  List<Object?> get props => [projectList];

  @override
  String toString() =>
      "ProjectStudentFetchSuccess { projectList: $projectList }";

  ProjectStudentFetchSuccess({
    required this.projectList,
  });
}

class ProjectStudentFetchFavoriteInProgress extends ProjectStudentState {
  @override
  String toString() => "ProjectStudentFetchInProgress {  }";
}

class ProjectStudentFetchFavoriteSuccess extends ProjectStudentState {
  final List<Project> favoriteProjectList;

  @override
  List<Object?> get props => [favoriteProjectList];

  @override
  String toString() =>
      "ProjectStudentFetchSuccess { projectList: $favoriteProjectList }";

  ProjectStudentFetchFavoriteSuccess({
    required this.favoriteProjectList,
  });
}
