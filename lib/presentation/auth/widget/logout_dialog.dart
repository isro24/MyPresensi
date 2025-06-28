import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/presentation/auth/bloc/login_bloc.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Konfirmasi Logout'),
      content: const Text('Apakah Anda yakin ingin keluar?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(ctx);
            context.read<LoginBloc>().add(LogoutRequested());
            context.go('/login'); 
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
