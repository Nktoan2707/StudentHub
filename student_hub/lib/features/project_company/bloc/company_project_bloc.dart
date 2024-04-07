import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/common/user_manager.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/features/project_company/bloc/company_project_event.dart';
import 'package:student_hub/features/project_company/bloc/company_project_state.dart';



class CompanyProjectBloc
    extends Bloc<CompanyProjectEvent, CompanyProjectState> {
  final ProjectRepository _projectRepository;

  CompanyProjectBloc({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(CompanyProjectStateInitial()) {
    on<CompanyProjectCreate>(_onCompanyProjectCreate);
    on<CompanyProjectListFetch>(_onCompanyProfileListFetch);
  }

    FutureOr<void> _onCompanyProjectCreate(CompanyProjectCreate event, Emitter<CompanyProjectState> emit) {
      emit(CompanyProjectStateInProgress());
    try {
      _projectRepository
          .createProject(UserManager.userInfo,event.projectCreate)
          .then((value) {
        if (!(value as bool)) {
          emit(CompanyProjectStateFailure());
          return;
        }
       emit(CompanyProjectStateSuccess(projectList: const []));
      });
    } catch (e) {
       emit(CompanyProjectStateFailure());
    }
  }

  FutureOr<void> _onCompanyProfileListFetch(
      CompanyProjectListFetch event, Emitter<CompanyProjectState> emit) {
   emit(CompanyProjectStateInProgress());
    try {
      _projectRepository
          .getListProject(UserManager.userInfo,"")
          .then((value) {
        if (!(value as bool)) {
          emit(CompanyProjectStateFailure());
          return;
        }
       emit(CompanyProjectStateSuccess(projectList: value));
      });
    } catch (e) {
       emit(CompanyProjectStateFailure());
    }
  }

}
