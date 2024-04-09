import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/common/constants.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';
import 'package:student_hub/data/models/domain/user.dart';

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
    on<ProjectStudentFavoriteFetched>(_onProjectStudentFavoriteFetched);
  }

  Future<FutureOr<void>> _onProjectStudentFetched(
      ProjectStudentFetched event, Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentFetchInProgress());

    try {
      List<Project> projectList = await _projectRepository.getListProject(
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token),
          filterQuery: ProjectQueryFilter(
              projectScopeFlag: ProjectScopeFlag.ThreeToSixMonth,
              numberOfStudents: 1,
              proposalsLessThan: 4),
          token: "123");
      emit(ProjectStudentFetchSuccess(projectList: projectList));
    } catch (e) {
      print(e);
    }
  }

  Future<FutureOr<void>> _onProjectStudentFavoriteFetched(
      ProjectStudentFavoriteFetched event,
      Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentFetchFavoriteInProgress());

    try {
      List<Project> projectList = await _projectRepository.getListProject(
          user: await _userRepository
              .getCurrentUser(_authenticationRepository.token),
          filterQuery: ProjectQueryFilter(
              projectScopeFlag: ProjectScopeFlag.ThreeToSixMonth,
              numberOfStudents: 1,
              proposalsLessThan: 4),
          token: "123");
      emit(
          ProjectStudentFetchFavoriteSuccess(favoriteProjectList: projectList));
    } catch (e) {
      print(e);
    }
  }
}
