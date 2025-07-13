import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/constant.dart';
import 'package:my_presensi/core/layouts/custome_default_app_bar.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/presentation/admin/employee_management/bloc/admin_employee_management_bloc.dart';
import 'package:my_presensi/presentation/admin/employee_management/home/widget/employee_list_item_card.dart';

class AdminEmployeeManagementScreen extends StatefulWidget {
  const AdminEmployeeManagementScreen({super.key});

  @override
  State<AdminEmployeeManagementScreen> createState() => _AdminEmployeeManagementScreenState();
}

class _AdminEmployeeManagementScreenState extends State<AdminEmployeeManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminEmployeeManagementBloc>().add(LoadAllEmployees());
    _searchController.addListener(() => setState(() {}));
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomeDefaultAppBar(title: 'Kelola Karyawan'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
            child: BlocListener<AdminEmployeeManagementBloc, AdminEmployeeManagementState>(
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
                    final query = _searchController.text.toLowerCase();
                    final filteredEmployees = state.employees.where((e) {
                      final name = e.name?.toLowerCase() ?? '';
                      final nip = e.employee?.nip ?? '';
                      return name.contains(query) || nip.contains(query);
                    }).toList();

                    if (filteredEmployees.isEmpty) {
                      return const EmptyDataView(
                        message: 'Karyawan tidak ditemukan.',
                        icon: Icons.person_off_outlined,
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredEmployees.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final employee = filteredEmployees[index];
                        return EmployeeListItemCard(
                          employee: employee,
                          onDelete: () => showDeleteEmployeeDialog(context, employee.id),
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
          ),
        ],
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
