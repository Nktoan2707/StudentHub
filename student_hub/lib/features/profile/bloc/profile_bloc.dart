import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final StudentRepository _studentRepository;

  ProfileBloc({
    required StudentRepository studentRepository,
  })  : _studentRepository = studentRepository,
        super(ProfileInitial()) {
      on<ProfileUpdated>(_onProfileUpdated);
  }



  FutureOr<void> _onProfileUpdated(ProfileUpdated event, Emitter<ProfileState> emit) {
    emit(ProfileUpdateInProgress());
    try {
      //gọi repository
      _studentRepository.getStudent();
      emit(ProfileUpdateSuccess());
    } catch (e){
      emit(ProfileUpdateFailure());
    }
  }
}
