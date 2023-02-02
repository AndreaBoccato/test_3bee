import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_3bee/blocs/login/login_bloc.dart';
import 'package:test_3bee/widgets/custom_snackbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prev, curr) => prev.formStatus != curr.formStatus,
        listener: (context, state) {
          if (state.formStatus == FormzStatus.submissionFailure) {
            context.showErrorSnackBar(message: 'Errore nel login');
          }

          if (state.formStatus == FormzStatus.submissionSuccess) {
            context.showSuccessSnackBar(message: 'Login effettuato con successo!');
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          }
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _IconLogo(),
                      SizedBox(height: 20),
                      _EmailInput(),
                      SizedBox(height: 20),
                      _PasswordInput(),
                      SizedBox(height: 20),
                      _SubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconLogo extends StatelessWidget {
  const _IconLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.emoji_nature_rounded,
      color: Colors.orange,
      size: 80,
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            label: const Text('Email'),
            errorText: state.email.invalid ? state.email.getErrorMessage() : null,
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.password != curr.password || prev.isPasswordVisible != curr.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            label: const Text('Password'),
            errorText: state.password.invalid ? state.password.getErrorMessage() : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(
                  state.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  context.read<LoginBloc>().add(PasswordVisibilityChanged());
                },
              ),
            ),
          ),
          obscureText: !state.isPasswordVisible,
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.formStatus != curr.formStatus,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: state.formStatus.isSubmissionInProgress
                      ? null
                      : () {
                          context.read<LoginBloc>().add(FormSubmitted());
                        },
                  child: state.formStatus.isSubmissionInProgress
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Login'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
