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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    attendanceBloc = EmployeeAttendanceBloc(AdminEmployeeAttendanceRepository(ServiceHttpClient()))
      ..add(GetAllEmployeeAttendanceEvent());

    _searchController.addListener(() => setState(() {}));
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Konfirmasi Hapus',
        message: 'Yakin ingin menghapus presensi ini?',
        onConfirm: () {
          attendanceBloc.add(DeleteEmployeeAttendanceEvent(id));
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => attendanceBloc,
      child: Scaffold(
        appBar: const CustomeDefaultAppBar(title: 'Presensi Karyawan'),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari berdasarkan nama atau NIP...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<EmployeeAttendanceBloc, EmployeeAttendanceState>(
                listener: (context, state) {
                  if (state is EmployeeAttendanceDeleted) {
                    showAppSnackBar(context, state.message, type: SnackBarType.success);
                    attendanceBloc.add(GetAllEmployeeAttendanceEvent());
                  } else if (state is EmployeeAttendanceError) {
                    showAppSnackBar(context, state.message, type: SnackBarType.error);
                  } else if (state is EmployeeAttendanceExportedToPdf) {
                    showAppSnackBar(context, 'Export berhasil', type: SnackBarType.success);
                  }
                },
                builder: (context, state) {
                  if (state is EmployeeAttendanceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is EmployeeAttendanceLoaded) {
                    final query = _searchController.text.toLowerCase();
                    final filtered = state.data.where((e) {
                      return e.name.toLowerCase().contains(query) || e.nip.toLowerCase().contains(query);
                    }).toList();

                    if (filtered.isEmpty) {
                      return const EmptyDataView(
                        message: 'Data tidak ditemukan.',
                        icon: Icons.search_off,
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final emp = filtered[index];
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
                      onRetry: () => attendanceBloc.add(GetAllEmployeeAttendanceEvent()),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<EmployeeAttendanceBloc, EmployeeAttendanceState>(
          builder: (context, state) {
            if (state is EmployeeAttendanceLoaded) {
              final query = _searchController.text.toLowerCase();
              final filtered = state.data.where((e) {
                return e.name.toLowerCase().contains(query) || e.nip.toLowerCase().contains(query);
              }).toList();

              final isDisabled = filtered.isEmpty;

              return FloatingActionButton.extended(
                onPressed: isDisabled
                    ? null
                    : () {
                        attendanceBloc.add(ExportEmployeeAttendanceToPdfEvent(filtered));
                      },
                label: const Text('Export PDF'),
                icon: const Icon(Icons.picture_as_pdf),
              );
            }

            return const SizedBox.shrink(); 
          },
        ),

      ),
    );
  }
}
