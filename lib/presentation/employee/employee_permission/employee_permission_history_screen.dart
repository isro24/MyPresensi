import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/presentation/employee/employee_permission/bloc/employee_permission_bloc.dart';

class EmployeePermissionHistoryScreen extends StatefulWidget {
  const EmployeePermissionHistoryScreen({super.key});

  @override
  State<EmployeePermissionHistoryScreen> createState() => _EmployeePermissionHistoryScreenState();
}

class _EmployeePermissionHistoryScreenState extends State<EmployeePermissionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeePermissionBloc>().add(LoadPermissionsEvent());
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'menunggu':
        return Colors.orange;
      case 'disetujui':
        return Colors.green;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const CustomeCrudAppBar(title: 'Riwayat Izin'),
      body: BlocBuilder<EmployeePermissionBloc, EmployeePermissionState>(
        builder: (context, state) {
          if (state is EmployeePermissionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeePermissionError) {
            return Center(child: Text(state.message));
          } else if (state is EmployeePermissionLoaded) {
            final permissions = state.permissions;
            if (permissions.isEmpty) {
              return const Center(child: Text('Belum ada pengajuan izin'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: permissions.length,
              itemBuilder: (context, index) {
                final permission = permissions[index];
                final start = permission.startDate?.toIso8601String().split('T').first ?? '-';
                final end = permission.endDate?.toIso8601String().split('T').first ?? '-';
                final reason = permission.reason ?? '-';
                final type = capitalize(permission.type ?? '-');
                final status = capitalize(permission.status ?? '-');

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 1,
                  color: Colors.white,
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(20),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                type,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(permission.status).withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color: _statusColor(permission.status),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              '$start s/d $end',
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.notes, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                reason,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );

              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
