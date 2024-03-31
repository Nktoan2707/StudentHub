import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';

import '../../../data/models/domain/student.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final StudentRepository _studentRepository;

  ProfileBloc({
    required StudentRepository studentRepository,
  })  : _studentRepository = studentRepository,
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileUpdated) {
      yield* _mapProfileUpdatedToState(event);
    }
  }

  Stream<ProfileState> _mapProfileUpdatedToState(ProfileUpdated event) async* {
    yield ProfileUpdateInProgress();
    try {
      final student = await _studentRepository.getStudent();
      if (student != null) {
        yield ProfileUpdateSuccess(student: student);
      } else {
        yield ProfileUpdateFailure();
      }
    } catch (e) {
      yield ProfileUpdateFailure();
    }
  }
}
