import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/components/buttons.dart';
import 'package:my_presensi/core/components/spaces.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/models/request/auth/forgot_password_request_model.dart';
import 'package:my_presensi/presentation/auth/bloc/login_bloc.dart';
import 'package:my_presensi/presentation/auth/reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Masukkan email untuk mendapatkan link reset password',
                textAlign: TextAlign.center,
              ),
              const SpaceHeight(20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Email wajib diisi' : null,
              ),
              const SpaceHeight(20),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    showAppSnackBar(context, state.message);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResetPasswordScreen(
                          email: state.email,
                          token: state.token,
                        ),
                      ),
                    );
                  } else if (state is LoginFailure) {
                    showAppSnackBar(context, state.error, type: SnackBarType.error);
                  }
                },

                builder: (context, state) {
                  return Button.filled(
                    label: state is LoginLoading ? 'Mengirim...' : 'Kirim Link Reset',
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    ForgotPasswordRequested(
                                      request: ForgotPasswordRequestModel(
                                        email: emailController.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
