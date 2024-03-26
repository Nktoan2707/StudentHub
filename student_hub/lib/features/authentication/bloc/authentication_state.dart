part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticateSuccess extends AuthenticationState {
  final User user;

  AuthenticationAuthenticateSuccess(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => "AuthenticationAuthenticateSuccess { User: $user }";
}

class AuthenticationAuthenticateFailure extends AuthenticationState {
  @override
  String toString() => "AuthenticationAuthenticateFailure: ";
}
