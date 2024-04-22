import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';

import '../../../data/models/domain/student_profile.dart';

part 'student_profile_event.dart';

part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final StudentRepository _studentRepository;
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  StudentProfileBloc(
      {required StudentRepository studentRepository,
      required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _studentRepository = studentRepository,
        _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(StudentProfileInitial()) {
    on<StudentProfileFetched>(_onStudentProfileFetched);
    on<StudentProfileUpdated>(_onStudentProfileUpdated);
  }

  Future<FutureOr<void>> _onStudentProfileFetched(
      StudentProfileFetched event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileFetchInProgress());
    try {
      final StudentProfile studentProfile = await _userRepository
          .getCurrentUser(_authenticationRepository.token)
          .then((user) async {
        if (user.studentProfile == null) {
          await _studentRepository.postStudentProfile(
              token: _authenticationRepository.token);
          _userRepository.doesNeedUpdate = true;
          return await _userRepository
              .getCurrentUser(_authenticationRepository.token)
              .then((user) => user.studentProfile!);
        }

        return user.studentProfile!;
      });

      final List<TechStack> allTechStackList =
          await _studentRepository.getAllTechStack();
      final List<SkillSet> allSkillSetList =
          await _studentRepository.getAllSkillSet();

      String? resumeUrl;
      if (studentProfile.resume != null) {
        resumeUrl = await _studentRepository.getStudentProfileResumeUrl(
            token: _authenticationRepository.token,
            studentId: studentProfile.id);
      }

      String? transcriptUrl;
      if (studentProfile.transcript != null) {
        transcriptUrl = await _studentRepository.getStudentProfileTranscriptUrl(
            token: _authenticationRepository.token,
            studentId: studentProfile.id);
      }

      emit(StudentProfileFetchSuccess(
          studentProfile: studentProfile!,
          resumeUrl: resumeUrl,
          transcriptUrl: transcriptUrl,
          allSkillSetList: allSkillSetList,
          allTechStackList: allTechStackList));
    } catch (e) {
      emit(StudentProfileFetchFailure());
      rethrow;
    }
  }

  Future<void> _onStudentProfileUpdated(
      StudentProfileUpdated event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileUpdateInProgress());
    try {
      await _studentRepository.putStudentProfile(
          studentId: await _userRepository
              .getCurrentUser(_authenticationRepository.token)
              .then((value) => value.studentProfile!.id),
          token: _authenticationRepository.token,
          studentProfile: event.studentProfile);
      emit(StudentProfileUpdateSuccess());
      add(StudentProfileFetched());
    } catch (e) {
      emit(StudentProfileUpdateFailure());
      add(StudentProfileFetched());
      rethrow;
    }
  }
}
