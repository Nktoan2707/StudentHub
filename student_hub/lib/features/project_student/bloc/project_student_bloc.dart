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
import 'package:student_hub/data/models/domain/user.dart';

part 'project_student_event.dart';

part 'project_student_state.dart';

class ProjectStudentBloc
    extends Bloc<ProjectStudentEvent, ProjectStudentState> {
  final ProjectRepository _projectRepository;

  ProjectStudentBloc({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(ProjectStudentInitial()) {
    on<ProjectStudentFetched>(_onProjectStudentFetched);
    on<ProjectStudentFavoriteFetched>(_onProjectStudentFavoriteFetched);
  }

  Future<FutureOr<void>> _onProjectStudentFetched(
      ProjectStudentFetched event, Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentFetchInProgress());
    List<Project> projectList = await _projectRepository.getProjectList();

    emit(ProjectStudentFetchSuccess(projectList: projectList));
  }

  Future<FutureOr<void>> _onProjectStudentFavoriteFetched(
      ProjectStudentFavoriteFetched event,
      Emitter<ProjectStudentState> emit) async {
    emit(ProjectStudentFetchFavoriteInProgress());
    List<Project> favoriteProjectList =
        await _projectRepository.getProjectList();

    emit(ProjectStudentFetchFavoriteSuccess(
        favoriteProjectList: favoriteProjectList));
  }
}
