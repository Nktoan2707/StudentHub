import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/common/constants.dart';
import 'package:student_hub/common/enums.dart';
import 'package:student_hub/data/data_providers/authentication_repository.dart';
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
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        UserRole userRole = prefs.getString(Constants.chosenUserRole) != null
            ? UserRole.values.firstWhere(
                (e) => e.name == prefs.getString(Constants.chosenUserRole))
            : UserRole.student;

        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationAuthenticateSuccess(
                  user: user, userRole: UserRole.student)
              : AuthenticationAuthenticateFailure(),
        );
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

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    _authenticationStateSubscription.cancel();
    return super.close();
  }
}
