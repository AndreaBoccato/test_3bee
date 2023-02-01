import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_3bee/blocs/login/login_bloc.dart';
import 'package:test_3bee/core/enums/form_status.dart';

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
          if (state.formStatus == FormStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Errore nel login'),
              ),
            );
          }

          if (state.formStatus == FormStatus.success) {
            // TODO: go to home page
          }
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _EmailInput(),
                      SizedBox(height: 12),
                      _PasswordInput(),
                      SizedBox(height: 12),
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

class _EmailInput extends StatefulWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            label: Text('Email'),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.password != curr.password || prev.isPasswordVisible != curr.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            label: Text('Password'),
          ),
          obscureText: state.isPasswordVisible,
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => prev.isSubmitting != curr.isSubmitting,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: state.isSubmitting
                    ? null
                    : () {
                        context.read<LoginBloc>().add(FormSubmitted());
                      },
                child: state.isSubmitting
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Login'),
              ),
            ),
          ],
        );
      },
    );
  }
}
