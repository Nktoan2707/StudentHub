import 'package:formz/formz.dart';

enum PasswordValidationError { empty, lessThan8Characters }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    if (value.length < 8) return PasswordValidationError.lessThan8Characters;
    return null;
  }
}
