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

class SignupEmailAddressChanged extends SignupEvent {
  final String emailAddress;

  SignupEmailAddressChanged(this.emailAddress);

  @override
  List<Object?> get props => [emailAddress];

  @override
  String toString() => "SignupUsernameChanged {emailAddress: $emailAddress}";
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  SignupPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];

  @override
  String toString() => "SignupPasswordChanged {password: $password}";
}

class SignupAgreeToTermChanged extends SignupEvent {
  final bool agreeToTerm;

  SignupAgreeToTermChanged(this.agreeToTerm);

  @override
  List<Object?> get props => [SignupAgreeToTermChanged];

  @override
  String toString() => "SignupAgreeToTermChanged {agreeToTerm: $agreeToTerm}";
}

class SignupUserRoleChosen extends SignupEvent {
  final UserRole userRole;

  SignupUserRoleChosen(this.userRole);

  @override
  List<Object?> get props => [userRole];

  @override
  String toString() => "SignupUserRoleChosen {userRole: $userRole}";
}

class SignupSignedUp extends SignupEvent {
  @override
  String toString() {
    return "SignupSignedUp {}";
  }
}
