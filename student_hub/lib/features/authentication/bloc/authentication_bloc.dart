import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/common/constants.dart';
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
  final CompanyRepository _companyRepository;
  final StudentRepository _studentRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStateSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required CompanyRepository companyRepository,
    required StudentRepository studentRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _companyRepository = companyRepository,
        _studentRepository = studentRepository,
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
        try {
          final user = await _userRepository
              .getCurrentUser(_authenticationRepository.token);
          return emit(
            user != null
                ? AuthenticationAuthenticateSuccess(
                    userRole: _authenticationRepository.currentUserRole)
                : AuthenticationAuthenticateFailure(),
          );
        } catch (e) {
          print(e);
          print("STATE AUTHENTICATION: $state");
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
}
