part of 'dashboard_student_accept_proposal_bloc.dart';

abstract class DashboardStudentAcceptEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardStudentAcceptProposalAccepted
    extends DashboardStudentAcceptEvent {
  final Proposal proposal;

  DashboardStudentAcceptProposalAccepted({required this.proposal});

  @override
  String toString() => "DashboardStudentAcceptProposalAccepted {}";
}
