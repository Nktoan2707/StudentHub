
import 'package:equatable/equatable.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';

abstract class CompanyProposalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyProposalListFetched extends CompanyProposalEvent {
  int projectId;
  CompanyProposalListFetched({
    required this.projectId
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProposalListFecthc $projectId";
  }
}

class CompanyProposalUpdated extends CompanyProposalEvent {
  Proposal updatedProposal;
  CompanyProposalUpdated({
    required this.updatedProposal
  });
  
  @override
  String toString() {
    return "[EVENT] CompanyProposalUpdated";
  }
}


