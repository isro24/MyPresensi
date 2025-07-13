import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/extension/int_ext.dart';

class AdminCard extends StatelessWidget {
  final AdminDashboardData data;

  const AdminCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final admin = data.admin;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                admin?.photo?.isNotEmpty == true ? NetworkImage(admin!.photo!) : null,
            child: admin?.photo?.isEmpty != false
                ? const Icon(Icons.person, size: 32, color: AppColors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(admin?.name ?? 'Admin',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Administrator', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          StreamBuilder<DateTime>(
            stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
            initialData: DateTime.now(),
            builder: (context, snapshot) {
              final now = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(now.formatTanggal, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(now.formatJam,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
