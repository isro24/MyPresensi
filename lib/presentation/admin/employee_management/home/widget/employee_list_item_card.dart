import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';

class EmployeeListItemCard extends StatelessWidget {
  final EmployeeManagementData employee;
  final VoidCallback onDelete;

  const EmployeeListItemCard({
    super.key,
    required this.employee,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final emp = employee.employee;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundImage: emp?.photoUrl != null ? NetworkImage(emp!.photoUrl!) : null,
          child: emp?.photoUrl == null ? const Icon(Icons.person) : null,
        ),
        title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NIP: ${emp?.nip ?? '-'}"),
            Text("Jabatan: ${emp?.position ?? '-'}"),
            Text("Departemen: ${emp?.department ?? '-'}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                context.push('/admin/employee_management/edit/${employee.id}');
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: () {
          context.push('/admin/employee_management/detail', extra: employee);
        },
      ),
    );
  }
}
