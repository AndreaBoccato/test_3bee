import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, incorrect }

class Password extends FormzInput<String, PasswordValidationError> {
  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]?)[A-Za-z\d@$!%*#?&]{8,}$');

  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value?.trim() ?? '') ? null : PasswordValidationError.invalid;
  }

  String? getErrorMessage() {
    switch (error) {
      case PasswordValidationError.invalid:
        return 'Password non valida';
      case PasswordValidationError.incorrect:
        return 'Password errata';
      case null:
        return null;
    }
  }
}
