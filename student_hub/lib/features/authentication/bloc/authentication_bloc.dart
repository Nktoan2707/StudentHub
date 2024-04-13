import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
import 'package:student_hub/data/data_providers/company_repository.dart';
import 'package:student_hub/data/data_providers/student_repository.dart';
import 'package:student_hub/data/data_providers/user_repository.dart';
import 'package:student_hub/data/models/domain/user.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStateSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(AuthenticationInitial()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLoggedOut>(_onAuthenticationLoggedOut);
    on<AuthenticationProfileSwitched>(_onAuthenticationProfileSwitched);

    _authenticationStateSubscription =
        _authenticationRepository.authenticationStatus.listen(
      (status) {
        add(_AuthenticationStatusChanged(status));
      },
    );
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationAuthenticateFailure());
      case AuthenticationStatus.authenticated:
        try {
          return emit(AuthenticationAuthenticateSuccess(
              user: await _userRepository
                  .getCurrentUser(_authenticationRepository.token),
              userRole: _authenticationRepository.currentUserRole));
        } catch (e) {
          // print(e);
          rethrow;
          emit(AuthenticationAuthenticateFailure());
        }
      default:
        throw Exception("Authentication Error!");
        break;
    }
  }

  void _onAuthenticationLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _authenticationStateSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onAuthenticationProfileSwitched(
      AuthenticationProfileSwitched event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationSwitchProfileInProgress());

    try {
      _authenticationRepository.currentUserRole = event.userRole;
      emit(AuthenticationSwitchProfileSuccess());
      add(_AuthenticationStatusChanged(AuthenticationStatus.authenticated));
    } catch (e) {
      emit(AuthenticationSwitchProfileFailure());
      add(_AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
    }
  }
}
