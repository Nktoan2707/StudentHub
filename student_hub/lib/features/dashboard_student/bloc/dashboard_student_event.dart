part of 'dashboard_student_bloc.dart';

abstract class DashboardStudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardStudentFetched extends DashboardStudentEvent {
  @override
  String toString() => "DashboardStudentFetched {}";
}
