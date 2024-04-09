part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class _AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  _AuthenticationStatusChanged(this.status);

  @override
  String toString() => "AuthenticationStatusChanged {status: $status}";
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  String toString() => "AuthenticationLoggedOut {}";
}
