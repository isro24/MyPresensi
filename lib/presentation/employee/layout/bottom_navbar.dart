import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';

class BottomNavbar extends StatelessWidget {
  final Widget child;

  const BottomNavbar({super.key, required this.child});

  int selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/employee/dashboard')) return 0;
    if (location.startsWith('/employee/attendance_history')) return 1;
    if (location.startsWith('/employee/profile')) return 2;
    return 0;
  }

  void bottomNav(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/employee/dashboard');
        break;
      case 1:
        context.go('/employee/attendance_history');
        break;
      case 2:
        context.go('/employee/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = selectedIndex(context);
      return Scaffold(
        body: child,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.white,
              currentIndex: currentIndex,
              onTap: (index) => bottomNav(context, index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), 
                  label: 'Dashboard'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history), 
                  label: 'Riwayat Kehadiran'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined), 
                  label: 'Profil'),
              ],
            ),
          ),
        ),
      );

  }
}
