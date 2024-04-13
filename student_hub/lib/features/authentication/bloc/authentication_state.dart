part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticateSuccess extends AuthenticationState {
  final User user;
  final UserRole userRole;

  @override
  List<Object?> get props => [];

  @override
  String toString() =>
      "AuthenticationAuthenticateSuccess { UserRole: $userRole }";

  AuthenticationAuthenticateSuccess({
    required this.userRole,
    required this.user
  });
}

class AuthenticationAuthenticateFailure extends AuthenticationState {
  @override
  String toString() => "AuthenticationAuthenticateFailure: ";
}

class AuthenticationSwitchProfileInProgress extends AuthenticationState {
  @override
  String toString() => "AuthenticationSwitchProfileInProgress: ";
}

class AuthenticationSwitchProfileSuccess extends AuthenticationState {
  @override
  String toString() => "AuthenticationSwitchProfileSuccess: ";
}

class AuthenticationSwitchProfileFailure extends AuthenticationState {
  @override
  String toString() => "AuthenticationSwitchProfileFailure: ";
}
