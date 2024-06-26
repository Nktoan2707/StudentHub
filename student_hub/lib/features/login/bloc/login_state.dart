part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;
  final String message;

  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.message = "",
  });

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    bool? isValid,
    String? message
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [status, username, password, isValid, message];
}