import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/proposal_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';

part 'dashboard_student_accept_proposal_event.dart';

part 'dashboard_student_accept_proposal_state.dart';

class DashboardStudentAcceptProposalBloc
    extends Bloc<DashboardStudentAcceptEvent, DashboardStudentAcceptProposalState> {
  final ProposalRepository _proposalRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  DashboardStudentAcceptProposalBloc(
      {required ProposalRepository proposalRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _proposalRepository = proposalRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(DashboardStudentAcceptInitial()) {
    on<DashboardStudentAcceptProposalAccepted>(
        _onDashboardStudentAcceptProposalAccepted);
  }

  Future<FutureOr<void>> _onDashboardStudentAcceptProposalAccepted(
      DashboardStudentAcceptProposalAccepted event,
      Emitter<DashboardStudentAcceptProposalState> emit) async {
    emit(DashboardStudentAcceptAcceptInProgress());

    try {
      await _proposalRepository.updateStatusProposal(
          proposal: event.proposal, token: _authenticationRepository.token);
      emit(DashboardStudentAcceptAcceptSuccess());
    } catch (e) {
      emit(DashboardStudentAcceptAcceptFailure());
      print(e);
      rethrow;
    }
  }
}
