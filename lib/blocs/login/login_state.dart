part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final FormStatus formStatus;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isSubmitting = false,
    this.formStatus = FormStatus.initial,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isSubmitting,
    FormStatus? formStatus,
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
