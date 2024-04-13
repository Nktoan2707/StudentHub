import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/data/models/domain/user.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';

class CompanyProjectBloc
    extends Bloc<CompanyProjectEvent, CompanyProjectState> {
  final ProjectRepository _projectRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  CompanyProjectBloc(
      {required ProjectRepository projectRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _projectRepository = projectRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(CompanyProjectStateInitial()) {
    on<CompanyProjectCreate>(_onCompanyProjectCreate);
    on<CompanyProjectListFetch>(_onCompanyProfileListFetch);
  }

  FutureOr<void> _onCompanyProjectCreate(
      CompanyProjectCreate event, Emitter<CompanyProjectState> emit) async {
    emit(CompanyProjectStateInProgress());

    User user = await _userRepository.getCurrentUser(_authenticationRepository.token);
    event.projectCreate.companyId = user.companyProfile!.id.toString();
    event.projectCreate.createdAt = DateTime.now().toString();

    try {
      await _projectRepository
          .createProject(
              user: await _userRepository
                  .getCurrentUser(_authenticationRepository.token),
              project: event.projectCreate,
              token: _authenticationRepository.token)
          .then((value) {
        if (!(value as bool)) {
          emit(CompanyProjectStateFailure());
          return;
        }
        emit(CompanyProjectPostStateSuccess());
      });
    } catch (e) {
      emit(CompanyProjectStateFailure());
    }
  }

  Future<FutureOr<void>> _onCompanyProfileListFetch(
      CompanyProjectListFetch event, Emitter<CompanyProjectState> emit) async {
    emit(CompanyProjectStateInProgress());
    try {
      await _projectRepository
          .getListCompanyProject(
              user: await _userRepository
                  .getCurrentUser(_authenticationRepository.token),
              typeFlag: event.typeFlag,
              token: _authenticationRepository.token)
          .then((value) {
        
        if (value is! List) {
          emit(CompanyProjectStateFailure());
          return;
        }
        emit(CompanyProjectStateSuccess(projectList: value!));
      });
    } catch (e) {
      print(e);
      emit(CompanyProjectStateFailure());
    }
  }
}
