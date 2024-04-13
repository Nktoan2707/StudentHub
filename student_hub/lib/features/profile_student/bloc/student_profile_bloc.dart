import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';

import '../../../data/models/domain/student_profile.dart';

part 'student_profile_event.dart';

part 'student_profile_state.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  final StudentRepository _studentRepository;

  StudentProfileBloc({
    required StudentRepository studentRepository,
  })  : _studentRepository = studentRepository,
        super(StudentProfileInitial()) {
    on<StudentProfileUpdate>(_onStudentProfileUpdate);
    on<StudentProfileFetch>(_onStudentProfileFetch);
  }

  Future<void> _onStudentProfileUpdate(
      StudentProfileUpdate event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileUpdateInProgress());
    try {
      final success = await _studentRepository.updateStudentProfile(event.updateProfile);
      if (success) {
        emit(StudentProfileUpdateSuccess());
      } else {
        emit(StudentProfileUpdateFailure());
      }
    } catch (e) {
      emit(StudentProfileUpdateFailure());
    }
  }

  Future<void> _onStudentProfileFetch(
      StudentProfileFetch event, Emitter<StudentProfileState> emit) async {
    emit(StudentProfileFetchInProgress());
    try {
      final studentProfile = await _studentRepository.getStudentProfile(event.id);
      if (studentProfile != null) {
        emit(StudentProfileFetchSuccess(newestStudentProfile: studentProfile));
      } else {
        emit(StudentProfileFetchFailure());
      }
    } catch (e) {
      emit(StudentProfileFetchFailure());
    }
  }
}
