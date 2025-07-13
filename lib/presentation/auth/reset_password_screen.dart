import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/components/buttons.dart';
import 'package:my_presensi/core/components/spaces.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/models/request/auth/reset_password_request_model.dart';
import 'package:my_presensi/presentation/auth/bloc/login_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String token;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool isShowPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Masukkan password baru Anda'),
              const SpaceHeight(20),
              TextFormField(
                controller: passwordController,
                obscureText: !isShowPassword,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  suffixIcon: IconButton(
                    icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => isShowPassword = !isShowPassword),
                  ),
                ),
                validator: (value) =>
                    value == null || value.length < 6 ? 'Minimal 6 karakter' : null,
              ),
              const SpaceHeight(20),
              TextFormField(
                controller: confirmController,
                obscureText: !isShowPassword,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password',
                ),
                validator: (value) =>
                    value != passwordController.text ? 'Password tidak cocok' : null,
              ),
              const SpaceHeight(20),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    showAppSnackBar(context, state.message);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else if (state is LoginFailure) {
                    showAppSnackBar(context, state.error, type: SnackBarType.error);
                  }
                },
                builder: (context, state) {
                  return Button.filled(
                    label: state is LoginLoading ? 'Memproses...' : 'Simpan Password Baru',
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    ResetPasswordRequested(
                                      request: ResetPasswordRequestModel(
                                        email: widget.email,
                                        token: widget.token,
                                        password: passwordController.text,
                                        passwordConfirmation: confirmController.text,
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
