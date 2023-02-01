import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  static final RegExp _emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value?.trim() ?? '') ? null : EmailValidationError.invalid;
  }

  String? getErrorMessage() {
    switch (error) {
      case EmailValidationError.invalid:
        return 'Email non valida';
      default:
        return null;
    }
  }
}
