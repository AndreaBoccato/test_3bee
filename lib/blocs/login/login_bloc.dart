import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3bee/core/enums/form_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  void _onPasswordVisibilityChanged(PasswordVisibilityChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isSubmitting: true,
    ));

    if (state.email.trim().isEmpty || state.password.trim().isEmpty) {
      emit(state.copyWith(
        isSubmitting: false,
        formStatus: FormStatus.error,
      ));
      return;
    }
  }
}
