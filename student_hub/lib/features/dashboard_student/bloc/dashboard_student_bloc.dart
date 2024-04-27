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

part 'dashboard_student_event.dart';

part 'dashboard_student_state.dart';

class DashboardStudentBloc
    extends Bloc<DashboardStudentEvent, DashboardStudentState> {
  final ProposalRepository _proposalRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  DashboardStudentBloc(
      {required ProposalRepository proposalRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _proposalRepository = proposalRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(DashboardStudentInitial()) {
    on<DashboardStudentFetched>(_onDashboardStudentFetched);
  }

  Future<FutureOr<void>> _onDashboardStudentFetched(
      DashboardStudentFetched event,
      Emitter<DashboardStudentState> emit) async {
    emit(DashboardStudentFetchInProgress());

    try {
      List<Proposal> proposalList =
          await _proposalRepository.getListProposalByStudentId(
              studentId: await _userRepository
                  .getCurrentUser(_authenticationRepository.token)
                  .then((value) => value.studentProfile!.id),
              token: _authenticationRepository.token);
      emit(DashboardStudentFetchSuccess(proposalList: proposalList));
    } catch (e) {
      emit(DashboardStudentFetchFailure());
      print(e);
      rethrow;
    }
  }
}
