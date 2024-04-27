part of 'submit_proposal_student_bloc.dart';

abstract class SubmitProposalStudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitProposalStudentSubmitted extends SubmitProposalStudentEvent {
  final int projectId;
  final String coverLetter;

  SubmitProposalStudentSubmitted({required this.projectId, required this.coverLetter});



  @override
  String toString() => "SubmitProposalStudentSubmitted {}";
}
