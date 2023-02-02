import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_3bee/core/instance_locator.dart';
import 'package:test_3bee/models/forms/email.dart';
import 'package:test_3bee/models/forms/password.dart';

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
    final Email email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? Email.pure(event.email) : email,
      formStatus: Formz.validate([email]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final Password password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.valid ? Password.pure(event.password) : password,
      formStatus: Formz.validate([password]),
    ));
  }

  void _onPasswordVisibilityChanged(PasswordVisibilityChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  Future _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    final Email email = Email.dirty(state.email.value);
    final Password password = Password.dirty(state.password.value);

    emit(state.copyWith(
      email: email,
      password: password,
      formStatus: Formz.validate([email, password]),
    ));

    if (state.formStatus.isValidated) {
      emit(state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
      ));

      try {
        final Map<String, dynamic> response = await commonService.authenticateUser(
          email: state.email.value.trim(),
          password: state.password.value.trim(),
        );

        await localCache.setAccessToken(response['access']);
        await localCache.setRefreshToken(response['refresh']);

        emit(state.copyWith(
          formStatus: FormzStatus.submissionSuccess,
        ));
      } catch (e) {
        log('Error executing request: ${e.toString()}');
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
        ));
      }
    }
  }
}
