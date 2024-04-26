import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/proposal_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_event.dart';
import 'package:student_hub/features/project_company/bloc/proposal/company_proposal_state.dart';

class CompanyProposalBloc
    extends Bloc<CompanyProposalEvent, CompanyProposalState> {
  final ProposalRepository _proposalRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  CompanyProposalBloc(
      {required ProposalRepository proposalRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _proposalRepository = proposalRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(CompanyProposalStateInitial()) {
    on<CompanyProposalListFetched>(_onCompanyProposalListFetched);
    on<CompanyProposalUpdated>(_onCompanyProposalUpdated);
  }


  FutureOr<void> _onCompanyProposalListFetched(CompanyProposalListFetched event, Emitter<CompanyProposalState> emit) async {
    emit(CompanyProposalStateInProgress());
    try {
      await _proposalRepository
          .getListProposal(
              projectId: event.projectId,
              token: _authenticationRepository.token)
          .then((value) {
        if (value is! List) {
          emit(CompanyProposalStateFailure());
          return;
        }
        emit(CompanyProposalStateSuccess(proposalList: value!));
      });
    } catch (e) {
      print(e);
      emit(CompanyProposalStateFailure());
    }
  }

  FutureOr<void> _onCompanyProposalUpdated(CompanyProposalUpdated event, Emitter<CompanyProposalState> emit) async {
    emit(CompanyProposalStateInProgress());
    try {
      await _proposalRepository
          .updateStatusProposal(
              proposal: event.updatedProposal,
              token: _authenticationRepository.token)
          .then((value) {
        if (value != true) {
          emit(CompanyProposalStateUpdateFailure());
          return;
        }
        emit(CompanyProposalStateUpdateSuccess());
      });
    } catch (e) {
      print(e);
      emit(CompanyProposalStateUpdateFailure());
    }
  }
}
