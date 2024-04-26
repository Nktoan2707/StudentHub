
import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/project.dart';

abstract class CompanyProposalState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProposalStateInitial extends CompanyProposalState {

}


class CompanyProposalStateInProgress extends CompanyProposalState {

}

class CompanyProposalStateSuccess extends CompanyProposalState {
  List <Proposal> proposalList;
  CompanyProposalStateSuccess({
    required this.proposalList,
  });

   @override
  List<Object?> get props => [proposalList];

  @override
  String toString() => "CompanyProposalStateSuccess { Company: $proposalList }";
}

class CompanyProposalStateFailure extends CompanyProposalState {

}