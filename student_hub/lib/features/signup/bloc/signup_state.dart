part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  final FormzSubmissionStatus status;
  final Username username;
  final EmailAddress emailAddress;
  final Password password;
  final Password confirmPassword;
  final bool agreeToTerm;
  final UserRole userRole;
  final bool isValid;

  @override
  List<Object?> get props => [
        status,
        username,
        password,
        confirmPassword,
        isValid,
        agreeToTerm,
        emailAddress,
        userRole
      ];

  const SignupState(
      {this.status = FormzSubmissionStatus.initial,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.confirmPassword = const Password.pure(),
      this.agreeToTerm = false,
      this.isValid = false,
      this.emailAddress = const EmailAddress.pure(),
      this.userRole = UserRole.student});

  SignupState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    EmailAddress? emailAddress,
    Password? password,
    Password? confirmPassword,
    bool? agreeToTerm,
    UserRole? userRole,
    bool? isValid,
  }) {
    return SignupState(
      status: status ?? this.status,
      username: username ?? this.username,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      agreeToTerm: agreeToTerm ?? this.agreeToTerm,
      userRole: userRole ?? this.userRole,
      isValid: isValid ?? this.isValid,
    );
  }
}
