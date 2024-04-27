part of 'submit_proposal_student_bloc.dart';

abstract class SubmitProposalStudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitProposalStudentInitial extends SubmitProposalStudentState {}

class SubmitProposalStudentPostInProgress extends SubmitProposalStudentState {
  @override
  String toString() => "SubmitProposalStudentPostInProgress {  }";
}

class SubmitProposalStudentPostSuccess extends SubmitProposalStudentState {
  @override
  String toString() => "SubmitProposalStudentPostSuccess {  }";
}

class SubmitProposalStudentPostFailure extends SubmitProposalStudentState {
  @override
  String toString() => "SubmitProposalStudentPostFailure {  }";
}