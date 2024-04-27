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

part 'submit_proposal_student_event.dart';

part 'submit_proposal_student_state.dart';

class SubmitProposalStudentBloc
    extends Bloc<SubmitProposalStudentEvent, SubmitProposalStudentState> {
  final ProposalRepository _proposalRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  SubmitProposalStudentBloc(
      {required ProposalRepository proposalRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _proposalRepository = proposalRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(SubmitProposalStudentInitial()) {
    on<SubmitProposalStudentSubmitted>(_onSubmitProposalStudentSubmitted);
  }

  Future<FutureOr<void>> _onSubmitProposalStudentSubmitted(
      SubmitProposalStudentSubmitted event,
      Emitter<SubmitProposalStudentState> emit) async {
    emit(SubmitProposalStudentPostInProgress());

    try {
      await _proposalRepository.postProposal(
          projectId: event.projectId,
          studentId: await _userRepository
              .getCurrentUser(_authenticationRepository.token)
              .then((value) => value.studentProfile!.id),
          coverLetter: event.coverLetter,
          token: _authenticationRepository.token);
      emit(SubmitProposalStudentPostSuccess());
    } catch (e) {
      emit(SubmitProposalStudentPostFailure());
      print(e);
      rethrow;
    }
  }
}
