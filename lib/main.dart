import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/data/repository/admin/admin_dashbaord_repository.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_management_repository.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_permission_repository.dart';
import 'package:my_presensi/data/repository/admin/admin_location_repository.dart';
import 'package:my_presensi/data/repository/admin/admin_profile_repository.dart';
import 'package:my_presensi/data/repository/auth_repository.dart';
import 'package:my_presensi/data/repository/employee/employee_attendance_repository.dart';
import 'package:my_presensi/data/repository/employee/employee_dashboard_repository.dart';
import 'package:my_presensi/data/repository/employee/employee_permission_repository.dart';
import 'package:my_presensi/data/repository/employee/employee_profile_repository.dart';
import 'package:my_presensi/presentation/admin/admin_employee_permission/bloc/admin_employee_permission_bloc.dart';
import 'package:my_presensi/presentation/admin/dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:my_presensi/presentation/admin/employee_management/bloc/admin_employee_management_bloc.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_bloc.dart';
import 'package:my_presensi/presentation/admin/profile/bloc/admin_profile_bloc.dart';
import 'package:my_presensi/presentation/auth/bloc/login_bloc.dart';
import 'package:my_presensi/presentation/employee/attendance/bloc/attendance_bloc/employee_attendance_bloc.dart';
import 'package:my_presensi/presentation/employee/attendance/bloc/camera_bloc/camera_bloc.dart';
import 'package:my_presensi/presentation/employee/attendance_history/bloc/attendance_history_bloc.dart';
import 'package:my_presensi/presentation/employee/dashboard/bloc/employee_dashboard_bloc.dart';
import 'package:my_presensi/presentation/employee/employee_permission/bloc/employee_permission_bloc.dart';
import 'package:my_presensi/presentation/employee/profile/bloc/employee_profile_bloc.dart';
import 'package:my_presensi/route.dart';
import 'package:my_presensi/service/service_http_client.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: AuthRepository(ServiceHttpClient())),
        ),

        //Employee
        BlocProvider(
          create: (context) =>
            DashboardBloc(dashboardRepository: DashboardRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            EmployeeProfileBloc(employeeProfileRepository: EmployeeProfileRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            CameraBloc(employeeAttendanceRepository: EmployeeAttendanceRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            EmployeeAttendanceBloc(employeeAttendanceRepository: EmployeeAttendanceRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            EmployeeAttendanceHistoryBloc(employeeAttendanceRepository: EmployeeAttendanceRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            EmployeePermissionBloc(repository: EmployeePermissionRepository(ServiceHttpClient())),
        ),

        //Admin
        BlocProvider(
          create: (context) =>
            AdminEmployeeManagementBloc(adminEmployeeManagementRepository: AdminEmployeeManagementRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            AdminProfileBloc(adminProfileRepository: AdminProfileRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            AdminDashboardBloc(adminDashboardRepository: AdminDashboardRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) =>
            AdminLocationBloc(adminLocationRepository: AdminLocationRepository(ServiceHttpClient()))
        ),
        BlocProvider(
          create: (context) => 
            AdminEmployeePermissionBloc(adminEmployeePermissionRepository: AdminEmployeePermissionRepository(ServiceHttpClient())),
        ),

      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MyPresensi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: router,
      ),
    );
  }
}
