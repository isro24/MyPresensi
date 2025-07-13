import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/components/empty_data.dart';
import 'package:my_presensi/core/components/error_view.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/presentation/admin/admin_employee_permission/bloc/admin_employee_permission_bloc.dart';
import 'package:my_presensi/presentation/admin/admin_employee_permission/widget/permission_card.dart';

class AdminEmployeePermissionScreen extends StatelessWidget {
  const AdminEmployeePermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: AppBar(
        title: const Text('Kelola Izin Pegawai'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AdminEmployeePermissionBloc, AdminEmployeePermissionState>(
        listener: (context, state) {
          if (state is AdminEmployeePermissionActionSuccess) {
            final status = state.message.toLowerCase();
            final type = status.contains('disetujui')
                ? SnackBarType.success
                : status.contains('ditolak')
                    ? SnackBarType.success
                    : SnackBarType.pending;

            showAppSnackBar(context, state.message, type: type);
            context.read<AdminEmployeePermissionBloc>().add(GetAdminEmployeePermissionsEvent());
          }
        },
        builder: (context, state) {
          if (state is AdminEmployeePermissionInitial || state is AdminEmployeePermissionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminEmployeePermissionError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<AdminEmployeePermissionBloc>().add(GetAdminEmployeePermissionsEvent()),
            );
          }

          if (state is AdminEmployeePermissionLoaded) {
            if (state.permissions.isEmpty) {
              return const EmptyDataView(message: "Tidak ada pengajuan izin.");
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.permissions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  PermissionCard(permission: state.permissions[index]),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
