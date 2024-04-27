part of 'dashboard_student_accept_proposal_bloc.dart';

abstract class DashboardStudentAcceptProposalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardStudentAcceptInitial extends DashboardStudentAcceptProposalState {}

class DashboardStudentAcceptAcceptInProgress
    extends DashboardStudentAcceptProposalState {
  @override
  String toString() => "DashboardStudentAcceptAcceptInProgress {  }";
}

class DashboardStudentAcceptAcceptSuccess extends DashboardStudentAcceptProposalState {
  @override
  String toString() => "DashboardStudentAcceptAcceptSuccess {  }";
}

class DashboardStudentAcceptAcceptFailure extends DashboardStudentAcceptProposalState {
  @override
  String toString() => "DashboardStudentAcceptAcceptFailure {  }";
}
