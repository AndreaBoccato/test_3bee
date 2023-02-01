part of 'login_bloc.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final FormzStatus formStatus;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isPasswordVisible = false,
    this.isSubmitting = false,
    this.formStatus = FormzStatus.pure,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? isPasswordVisible,
    bool? isSubmitting,
    FormzStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isPasswordVisible,
        isSubmitting,
        formStatus,
      ];
}
