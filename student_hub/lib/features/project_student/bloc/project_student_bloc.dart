import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/features/project_student/pages/student_project_list_page.dart';

part 'project_student_event.dart';

part 'project_student_state.dart';

class ProjectStudentBloc
    extends Bloc<ProjectStudentEvent, ProjectStudentState> {
  final ProjectRepository _projectRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  ProjectStudentBloc(
      {required ProjectRepository projectRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _projectRepository = projectRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(ProjectStudentInitial()) {
    on<ProjectStudentFetched>(_onProjectStudentFetched);
    on<ProjectStudentUpdated>(_onProjectStudentUpdated);
    on<ProjectStudentSearched>(_onProjectStudentSearched);
  }

  Future<FutureOr<void>> _onProjectStudentFetched(
      ProjectStudentFetched event, Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentFetchInProgress());

    try {
      List<Project> projectList = await _projectRepository.getListProject(
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token),
          filterQuery: ProjectQueryFilter(),
          token: _authenticationRepository.token);

      List<Project> favoriteProjectList =
          projectList.where((element) => element.isFavorite).toList();

      emit(ProjectStudentFetchSuccess(
          projectList: projectList, favoriteProjectList: favoriteProjectList));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<FutureOr<void>> _onProjectStudentUpdated(
      ProjectStudentUpdated event, Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentUpdateInProgress());

    try {
      await _projectRepository.patchStudentFavoriteProject(
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token),
          projectId: event.projectId,
          isDisabled: event.isDisabled,
          token: _authenticationRepository.token);

      emit(ProjectStudentUpdateSuccess(callerPageId: event.callerPageId));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<FutureOr<void>> _onProjectStudentSearched(
      ProjectStudentSearched event, Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentSearchInProgress());

    try {
      print(event.projectQueryFilter.toMap());

      List<Project> projectList = await _projectRepository.getListProject(
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token),
          filterQuery: event.projectQueryFilter,
          token: _authenticationRepository.token);

      emit(ProjectStudentSearchSuccess(searchedProjectList: projectList, projectQueryFilter: event.projectQueryFilter));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
