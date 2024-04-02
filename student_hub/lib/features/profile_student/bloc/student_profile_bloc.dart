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
        super(StudentProfileInitial());

  @override
  Stream<StudentProfileState> mapEventToState(StudentProfileEvent event) async* {
    if (event is StudentProfileUpdated) {
      yield* _mapProfileUpdatedToState(event);
    }
  }

  Stream<StudentProfileState> _mapProfileUpdatedToState(StudentProfileUpdated event) async* {
    yield StudentProfileUpdateInProgress();
    try {
      final student = await _studentRepository.getStudent();
      if (student != null) {
        yield StudentProfileUpdateSuccess(student: student);
      } else {
        yield StudentProfileUpdateFailure();
      }
    } catch (e) {
      yield StudentProfileUpdateFailure();
    }
  }
}
