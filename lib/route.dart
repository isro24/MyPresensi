import 'package:go_router/go_router.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_attendance_response_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_location_response_model.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'package:my_presensi/presentation/admin/admin_employee_permission/admin_employee_permission_screen.dart';
import 'package:my_presensi/presentation/admin/dashboard/admin_dashboard_screen.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/detail/admin_employee_attendance_detail_screen.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/home/admin_employee_attendance_screen.dart';
import 'package:my_presensi/presentation/admin/employee_management/admin_employee_management_create_screen.dart';
import 'package:my_presensi/presentation/admin/employee_management/detail/admin_employee_management_detail_screen.dart';
import 'package:my_presensi/presentation/admin/employee_management/home/admin_employee_management_screen.dart';
import 'package:my_presensi/presentation/admin/employee_management/admin_employee_management_update_screen.dart';
import 'package:my_presensi/presentation/admin/location/admin_location_create_screen.dart';
import 'package:my_presensi/presentation/admin/location/admin_location_screen.dart';
import 'package:my_presensi/presentation/admin/location/admin_location_update_screen.dart';
import 'package:my_presensi/presentation/admin/profile/home/admin_profile_screen.dart';
import 'package:my_presensi/presentation/admin/profile/update/admin_profile_update_screen.dart';
import 'package:my_presensi/presentation/admin/layout/admin_bottom_navbar.dart';
import 'package:my_presensi/presentation/auth/forgot_password_screen.dart';
import 'package:my_presensi/presentation/auth/login_screen.dart';
import 'package:my_presensi/presentation/auth/reset_password_screen.dart';
import 'package:my_presensi/presentation/employee/attendance/employee_attendance_camera.dart';
import 'package:my_presensi/presentation/employee/attendance/employee_attendance_screen.dart';
import 'package:my_presensi/presentation/employee/attendance_history/pages/detail/employee_attendance_detail_screen.dart';
import 'package:my_presensi/presentation/employee/attendance_history/pages/home/employee_attendance_history_screen.dart';
import 'package:my_presensi/presentation/employee/dashboard/employee_dashboard_screen.dart';
import 'package:my_presensi/presentation/employee/employee_permission/employee_permission_history_screen.dart';
import 'package:my_presensi/presentation/employee/employee_permission/home/employee_permission_form_screen.dart';
import 'package:my_presensi/presentation/employee/profile/employee_profile_screen.dart';
import 'package:my_presensi/presentation/employee/profile/employee_update_profile_sreen.dart';
import 'package:my_presensi/presentation/employee/layout/bottom_navbar.dart';
import 'package:my_presensi/presentation/main/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Login
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/auth/reset-password',
      builder: (context, state) {
        final email = state.uri.queryParameters['email'] ?? '';
        final token = state.uri.queryParameters['token'] ?? '';
        return ResetPasswordScreen(email: email, token: token);
      },
    ),


    // Employee Route
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavbar(child: child); 
      },
      routes: [
        GoRoute(
          path: '/employee/dashboard',
          builder: (context, state) => const DashboardEmployeeScreen(),
        ),
        GoRoute(
          path: '/employee/attendance_history',
          builder: (context, state) => const EmployeeAttendanceHistoryScreen(),
        ),
        GoRoute(
          path: '/employee/profile',
          builder: (context, state) => const EmployeeProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/employee/profile/edit',
      builder: (context, state) => const EmployeeUpdateProfileScreen(),
    ),

    GoRoute(
      path: '/employee/attendance/in',
      builder: (context, state) => const EmployeeAttendanceScreen(isClockIn: true),
    ),
    GoRoute(
      path: '/employee/attendance/out',
      builder: (context, state) => const EmployeeAttendanceScreen(isClockIn: false),
    ),

    GoRoute(
      path: '/employee/attendance/detail',
      builder: (context, state) {
        final data = state.extra as Data;
        return EmployeeAttendanceDetailScreen(attendance: data);
      },
    ),

    GoRoute(
      path: '/employee/attendance/camera',
      builder: (context, state) => const EmployeeAttendanceCamera(),
    ),

    GoRoute(
      path: '/employee/permission/form',
      builder: (context, state) => const EmployeePermissionFormScreen(),
    ),

    GoRoute(
      path: '/employee/permission/history',
      builder: (context, state) => const EmployeePermissionHistoryScreen(),
    ),

    // Admin Route
    ShellRoute(
      builder: (context, state, child) {
        return AdminBottomNavbar(child: child); 
      },
      routes: [
        GoRoute(
          path: '/admin/dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/employee_management',
          builder: (context, state) => const AdminEmployeeManagementScreen(),
        ),
        GoRoute(
          path: '/admin/employee_attendance',
          builder: (context, state) => const AdminEmployeeAttendanceScreen()
        ),
        GoRoute(
          path: '/admin/profile',
          builder: (context, state) => const AdminProfileScreen()
        )
      ],
    ),
    GoRoute(
      path: '/admin/profile/edit',
      builder: (context, state) => const AdminUpdateProfileScreen(),
    ),
    GoRoute(
      path: '/admin/employee_management',
      builder: (context, state) => const AdminEmployeeManagementScreen(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const AdminEmployeeCreateScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return AdminEmployeeUpdateScreen(id: id);
          },
        ),
      ],
    ),

    GoRoute(
      path: '/admin/employee/attendance/detail',
      builder: (context, state) {
        final employeeAttendanceData = state.extra as EmployeeAttendanceData;
        return AdminEmployeeAttendanceDetailScreen(attendance: employeeAttendanceData);
      },
    ),

    GoRoute(
      path: '/admin/employee_management/detail',
      builder: (context, state) {
        final data = state.extra as EmployeeManagementData;
        return AdminEmployeeDetailScreen(employee: data);
      },
    ),


    GoRoute(
      path: '/admin/permission',
      builder: (context, state) => const AdminEmployeePermissionScreen(),
    ),

    GoRoute(
      path: '/admin/location',
      builder: (context, state) => const AdminLocationScreen(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) {
            return const AdminLocationCreateScreen();
          },
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            final locationData = state.extra as LocationData;
            return AdminLocationUpdateScreen(id: id, location: locationData);
          },
        ),
      ],
    ),
  ],
);
