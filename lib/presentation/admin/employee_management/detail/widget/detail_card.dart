import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/presentation/admin/employee_management/detail/widget/detail_row.dart';

class DetailCard extends StatelessWidget {
  final EmployeeManagementData employee;

  const DetailCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final detail = employee.employee;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: detail?.photoUrl != null
                    ? NetworkImage(detail!.photoUrl!)
                    : null,
                child: detail?.photoUrl == null
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            DetailRow(label: "Nama", value: employee.name),
            DetailRow(label: "NIP", value: detail?.nip),
            DetailRow(label: "Email", value: employee.email),
            DetailRow(label: "No. Telepon", value: detail?.phone),
            DetailRow(label: "Jabatan", value: detail?.position),
            DetailRow(label: "Departemen", value: detail?.department),
            DetailRow(label: "Alamat", value: detail?.address),
          ],
        ),
      ),
    );
  }
}
