import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';

class AdminBottomNavbar extends StatelessWidget {
  final Widget child;

  const AdminBottomNavbar({super.key, required this.child});

  int selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/admin/dashboard')) return 0;
    if (location.startsWith('/admin/employee_management')) return 1;
    if (location.startsWith('/admin/employee_attendance')) return 2;
    if (location.startsWith('/admin/profile')) return 3;

    return 0;
  }

  void bottomNav(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/admin/dashboard');
        break;
      case 1:
        context.go('/admin/employee_management');
        break;
      case 2:
        context.go('/admin/employee_attendance');
        break;
      case 3:
        context.go('/admin/profile');
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
                  icon: Icon(Icons.group_outlined), 
                  label: 'Karyawan'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_reg_outlined), 
                  label: 'Kehadiran'),
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
