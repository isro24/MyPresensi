import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/data/repository/auth_repository.dart';
import 'package:my_presensi/service/service_http_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authRepository = AuthRepository(ServiceHttpClient());

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final isValid = await authRepository.me();
    
    if (!mounted) return;
    if (isValid) {
      final role = await authRepository.secureStorage.read(key: 'userRole');
      if (!mounted) return;

      if (role == 'admin') {
        context.go('/admin/dashboard');
      } else {
        context.go('/employee/dashboard');
      }
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
