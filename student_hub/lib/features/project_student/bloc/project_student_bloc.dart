import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/project_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/project.dart';
import 'package:student_hub/data/models/domain/project_query_filter.dart';

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
}
