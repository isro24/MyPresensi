import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/constant.dart';
import 'package:my_presensi/core/layouts/custome_default_app_bar.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/core/components/components.dart'; // ⬅️ pastikan komponen globalmu diimpor di sini
import 'package:my_presensi/presentation/admin/employee_management/bloc/admin_employee_management_bloc.dart';
import 'package:my_presensi/presentation/admin/employee_management/home/widget/employee_list_item_card.dart';

class AdminEmployeeManagementScreen extends StatefulWidget {
  const AdminEmployeeManagementScreen({super.key});

  @override
  State<AdminEmployeeManagementScreen> createState() => _AdminEmployeeManagementScreenState();
}

class _AdminEmployeeManagementScreenState extends State<AdminEmployeeManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminEmployeeManagementBloc>().add(LoadAllEmployees());
  }

  void showDeleteEmployeeDialog(BuildContext context, int employeeId) {
    showDialog(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Konfirmasi Hapus',
        message: 'Apakah Anda yakin ingin menghapus karyawan ini?',
        onConfirm: () {
          context.read<AdminEmployeeManagementBloc>().add(DeleteEmployee(employeeId));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomeDefaultAppBar(title: 'Kelola Karyawan'),
      body: BlocListener<AdminEmployeeManagementBloc, AdminEmployeeManagementState>(
        listener: (context, state) {
          if (state is DeleteEmployeeSuccess) {
            showAppSnackBar(context, state.message, type: SnackBarType.success);
          } else if (state is UpdateEmployeeSuccess) {
            showAppSnackBar(context, state.message, type: SnackBarType.success);
          } else if (state is CreateEmployeeSuccess) {
            showAppSnackBar(context, state.message, type: SnackBarType.success);
          } else if (state is EmployeeManagementError) {
            showAppSnackBar(context, state.message, type: SnackBarType.error);
          }
        },
        child: BlocBuilder<AdminEmployeeManagementBloc, AdminEmployeeManagementState>(
          builder: (context, state) {
            if (state is AdminEmployeeManagementLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminEmployeeManagementLoaded) {
              if (state.employees.isEmpty) {
                return const EmptyDataView(
                  message: 'Belum ada data karyawan.',
                  icon: Icons.people_outline,
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.employees.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final e = state.employees[index];
                  return EmployeeListItemCard(
                    employee: e,
                    onDelete: () => showDeleteEmployeeDialog(context, e.id),
                  );
                },
              );
            } else {
              return ErrorView(
                message: 'Gagal memuat data.',
                onRetry: () {
                  context.read<AdminEmployeeManagementBloc>().add(LoadAllEmployees());
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/admin/employee_management/create');
        },
        backgroundColor: AppColors.primary,
        label: const Text("Tambah", style: TextStyle(color: AppColors.white)),
        icon: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
