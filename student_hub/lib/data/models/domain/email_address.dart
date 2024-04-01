import 'package:formz/formz.dart';

enum EmailAddressValidationError { empty }

class EmailAddress extends FormzInput<String, EmailAddressValidationError> {
  const EmailAddress.pure() : super.pure('');

  const EmailAddress.dirty([super.value = '']) : super.dirty();

  @override
  EmailAddressValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailAddressValidationError.empty;
    }

    return null;
  }
}
