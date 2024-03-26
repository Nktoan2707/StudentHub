part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupUsernameChanged extends SignupEvent {
  final String username;

  SignupUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];

  @override
  String toString() => "SignupUsernameChanged {username: $username}";
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  SignupPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  String toString() => "SignupPasswordChanged {password: $password}";
}

class SignupSignedUp extends SignupEvent {
  @override
  String toString() {
    return "SignupSignedUp {}";
  }
}
