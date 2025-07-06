import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/presentation/admin/employee_management/detail/widget/detail_card.dart';

class AdminEmployeeDetailScreen extends StatelessWidget {
  final EmployeeManagementData employee;

  const AdminEmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Karyawan", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DetailCard(employee: employee),
      ),
    );
  }
}
