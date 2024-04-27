part of 'dashboard_student_bloc.dart';

abstract class DashboardStudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardStudentInitial extends DashboardStudentState {}

class DashboardStudentFetchInProgress extends DashboardStudentState {
  @override
  String toString() => "DashboardStudentFetchInProgress {  }";
}

class DashboardStudentFetchSuccess extends DashboardStudentState {
  final List<Proposal> proposalList;

  DashboardStudentFetchSuccess({required this.proposalList});

  @override
  String toString() =>
      "DashboardStudentFetchSuccess { proposalList: $proposalList }";
}

class DashboardStudentFetchFailure extends DashboardStudentState {
  @override
  String toString() => "DashboardStudentFetchFailure {  }";
}

class DashboardStudentUpdateInProgress extends DashboardStudentState {
  @override
  String toString() => "DashboardStudentUpdateInProgress { }";
}

class DashboardStudentUpdateSuccess extends DashboardStudentState {
  final String? callerPageId;

  DashboardStudentUpdateSuccess({this.callerPageId});

  @override
  String toString() => "ProjectStudentSaveInProgress { }";
}

class DashboardStudentUpdateFailure extends DashboardStudentState {
  @override
  String toString() => "DashboardStudentUpdateFailure { }";
}


