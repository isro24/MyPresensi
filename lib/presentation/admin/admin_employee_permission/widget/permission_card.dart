import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_permission_response_model.dart';
import 'package:my_presensi/presentation/admin/admin_employee_permission/bloc/admin_employee_permission_bloc.dart';

class PermissionCard extends StatelessWidget {
  final AdminEmployeePermissionData permission;

  const PermissionCard({super.key, required this.permission});

  @override
  Widget build(BuildContext context) {
    final emp = permission.employee;
    final name = emp?.user?.name ?? '-';
    final position = emp?.position ?? '-';
    final photoFile = emp?.photo; 

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _EmployeeAvatar(photoFile),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              _PopupStatusMenu(permission: permission),
            ],
          ),
          const SizedBox(height: 6),
          Text('$position • ${permission.type ?? '-'}',
              style: const TextStyle(fontSize: 12)),
          Text(
              '${permission.startDate?.toIso8601String().split('T').first ?? '-'}'
              ' - ${permission.endDate?.toIso8601String().split('T').first ?? '-'}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text("Alasan: ${permission.reason ?? '-'}",
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _EmployeeAvatar extends StatelessWidget {
  final String? photoUrl;

  const _EmployeeAvatar(this.photoUrl);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
          ? NetworkImage(photoUrl!)
          : null,
      child: (photoUrl == null || photoUrl!.isEmpty)
          ? const Icon(Icons.person, color: Colors.grey)
          : null,
    );
  }
}

class _PopupStatusMenu extends StatelessWidget {
  final AdminEmployeePermissionData permission;

  const _PopupStatusMenu({required this.permission});

  @override
  Widget build(BuildContext context) {
    final statusColor = permission.status == 'disetujui'
        ? Colors.green
        : permission.status == 'ditolak'
            ? Colors.red
            : Colors.orange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _statusText(permission.status),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: statusColor,
          ),
        ),
        const SizedBox(height: 4),
        PopupMenuButton<String>(
          onSelected: (value) {
            context.read<AdminEmployeePermissionBloc>().add(
                UpdateAdminEmployeePermissionStatusEvent(permission.id!, value));
          },
          itemBuilder: (context) => [
            if (permission.status != 'disetujui')
              const PopupMenuItem(value: 'disetujui', child: Text('Setujui')),
            if (permission.status != 'ditolak')
              const PopupMenuItem(value: 'ditolak', child: Text('Tolak')),
            if (permission.status != 'menunggu')
              const PopupMenuItem(value: 'menunggu', child: Text('Tandai Menunggu')),
          ],
          child: const Icon(Icons.edit, size: 20),
        ),
      ],
    );
  }

  String _statusText(String? status) {
    switch (status) {
      case 'disetujui':
        return 'Disetujui';
      case 'ditolak':
        return 'Ditolak';
      case 'menunggu':
        return 'Menunggu';
      default:
        return '-';
    }
  }
}
