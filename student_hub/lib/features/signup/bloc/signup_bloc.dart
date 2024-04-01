import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/common/constants.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/models/domain/email_address.dart';
import 'package:student_hub/data/models/domain/password.dart';
import 'package:student_hub/data/models/domain/username.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository _authenticationRepository;

  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<SignupUsernameChanged>(_onSignupUsernameChanged);
    on<SignupEmailAddressChanged>(_onSignupEmailAddressChanged);
    on<SignupPasswordChanged>(_onSignupPasswordChanged);
    on<SignupAgreeToTermChanged>(_onSignupAgreeToTermChanged);
    on<SignupUserRoleChosen>(_onSignupUserRoleChosen);
    on<SignupSignedUp>(_onSignupSignedUp);
  }

  void _onSignupUsernameChanged(
    SignupUsernameChanged event,
    Emitter<SignupState> emit,
  ) {
    final username = Username.dirty(event.username);

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.initial,
        username: username,
        isValid:
            Formz.validate([state.password, state.emailAddress, username]) &&
                state.agreeToTerm == true,
      ),
    );
  }

  void _onSignupPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
          password: password,
          isValid:
              Formz.validate([password, state.username, state.emailAddress]) &&
                  state.agreeToTerm == true),
    );
  }

  Future<void> _onSignupSignedUp(
    SignupSignedUp event,
    Emitter<SignupState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(
            username: state.username.value,
            emailAddress: state.emailAddress.value,
            password: state.password.value,
            userRole: state.userRole);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<FutureOr<void>> _onSignupUserRoleChosen(
      SignupUserRoleChosen event, Emitter<SignupState> emit) async {
    // Obtain shared preferences.
    emit(
      state.copyWith(
        userRole: event.userRole,
        isValid: Formz.validate(
                [state.emailAddress, state.username, state.password]) &&
            state.agreeToTerm == true,
      ),
    );
  }

  FutureOr<void> _onSignupEmailAddressChanged(
      SignupEmailAddressChanged event, Emitter<SignupState> emit) {
    final emailAddress = EmailAddress.dirty(event.emailAddress);
    emit(
      state.copyWith(
        emailAddress: emailAddress,
        isValid:
            Formz.validate([emailAddress, state.username, state.password]) &&
                state.agreeToTerm == true,
      ),
    );
  }

  FutureOr<void> _onSignupAgreeToTermChanged(
      SignupAgreeToTermChanged event, Emitter<SignupState> emit) {
    emit(
      state.copyWith(
        agreeToTerm: event.agreeToTerm,
        isValid: Formz.validate(
                [state.emailAddress, state.username, state.password]) &&
            event.agreeToTerm == true,
      ),
    );
  }
}
