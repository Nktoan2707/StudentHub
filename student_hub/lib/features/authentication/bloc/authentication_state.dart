part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticateSuccess extends AuthenticationState {
  final UserRole userRole;

  @override
  List<Object?> get props => [];

  @override
  String toString() =>
      "AuthenticationAuthenticateSuccess { UserRole: $userRole }";

  AuthenticationAuthenticateSuccess({
    required this.userRole,
  });
}

class AuthenticationAuthenticateFailure extends AuthenticationState {
  @override
  String toString() => "AuthenticationAuthenticateFailure: ";
}
