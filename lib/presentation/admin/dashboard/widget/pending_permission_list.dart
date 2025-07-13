import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/utils/global_vertical_list.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class PendingPermissionList extends StatelessWidget {
  final List<PendingPermission>? list;

  const PendingPermissionList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada pengajuan izin yang menunggu.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalVerticalPaginatedList(
          itemCount: list!.length,
          itemsPerPage: 5,
          itemBuilder: (context, index) {
            final perm = list![index];
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
                      CircleAvatar(
                        backgroundImage: perm.photo != null
                            ? NetworkImage(perm.photo!)
                            : null,
                        child: perm.photo == null ? const Icon(Icons.person) : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          perm.name ?? '-',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${perm.position ?? '-'} • ${perm.type ?? '-'}',
                      style: const TextStyle(fontSize: 12)),
                  Text('${perm.startDate} - ${perm.endDate}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => context.push('/admin/permission'),
            icon: const Icon(Icons.manage_accounts),
            label: const Text('Kelola Izin'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
