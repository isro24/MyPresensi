import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/layouts/custome_default_app_bar.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/repository/admin/admin_employee_attendance_repository.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/home/widget/attendance_list_item.dart';
import 'package:my_presensi/service/service_http_client.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/bloc/employee_attendance_bloc.dart';

class AdminEmployeeAttendanceScreen extends StatefulWidget {
  const AdminEmployeeAttendanceScreen({super.key});

  @override
  State<AdminEmployeeAttendanceScreen> createState() => _AdminEmployeeAttendanceScreenState();
}

class _AdminEmployeeAttendanceScreenState extends State<AdminEmployeeAttendanceScreen> {
  late final EmployeeAttendanceBloc attendanceBloc;

  @override
  void initState() {
    super.initState();
    attendanceBloc = EmployeeAttendanceBloc(AdminEmployeeAttendanceRepository(ServiceHttpClient()))
      ..add(GetAllEmployeeAttendanceEvent());
  }

  void _showDeleteConfirmation(BuildContext context, int attendanceId) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Konfirmasi Hapus',
        message: 'Apakah Anda yakin ingin menghapus data presensi ini?',
        onConfirm: () {
          attendanceBloc.add(DeleteEmployeeAttendanceEvent(attendanceId));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => attendanceBloc,
      child: Scaffold(
      appBar: const CustomeDefaultAppBar(title: 'Presensi Karyawan'),
        body: BlocConsumer<EmployeeAttendanceBloc, EmployeeAttendanceState>(
          listener: (context, state) {
            if (state is EmployeeAttendanceDeleted) {
              showAppSnackBar(context, state.message, type: SnackBarType.success);
              attendanceBloc.add(GetAllEmployeeAttendanceEvent());
            } else if (state is EmployeeAttendanceError) {
              showAppSnackBar(context, state.message, type: SnackBarType.error);
            }
          },
          builder: (context, state) {
            if (state is EmployeeAttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is EmployeeAttendanceLoaded) {
              if (state.data.isEmpty) {
                return const EmptyDataView(
                  message: 'Belum ada data presensi.',
                  icon: Icons.access_time,
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final emp = state.data[index];
                  return EmployeeAttendanceListItem(
                    name: emp.name,
                    nip: emp.nip,
                    photoBytes: emp.photoClockInBytes,
                    onTap: () => context.push('/admin/employee/attendance/detail', extra: emp),
                    onDelete: () => _showDeleteConfirmation(context, emp.id),
                  );
                },
              );
            }

            if (state is EmployeeAttendanceError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  attendanceBloc.add(GetAllEmployeeAttendanceEvent());
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
