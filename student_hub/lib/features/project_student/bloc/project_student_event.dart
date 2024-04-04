part of 'project_student_bloc.dart';

abstract class ProjectStudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class ProjectStudentFetched extends ProjectStudentEvent {
  @override
  String toString() => "ProjectStudentFetched {}";
}

class ProjectStudentFavoriteFetched extends ProjectStudentEvent {
  @override
  String toString() => "ProjectStudentFavoriteFetched {}";
}
