part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged(this.username);


  @override
  List<Object?> get props => [username];

  @override
  String toString() => "LoginUsernameChanged {username: $username}";
}

class LoginPasswordChanged  extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  String toString() => "LoginPasswordChanged {password: $password}";
}

class LoginLoggedIn extends LoginEvent {
  @override
  String toString() {
    return "LoginLoggedIn {}";
  }
}