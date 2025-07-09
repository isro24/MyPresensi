import 'package:flutter/material.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/presentation/admin/employee_management/detail/widget/detail_card.dart';

class AdminEmployeeDetailScreen extends StatelessWidget {
  final EmployeeManagementData employee;

  const AdminEmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomeCrudAppBar(title: 'Detail Karyawan'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DetailCard(employee: employee),
      ),
    );
  }
}
