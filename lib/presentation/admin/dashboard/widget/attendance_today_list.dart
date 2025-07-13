import 'package:flutter/material.dart';
import 'package:my_presensi/core/utils/global_vertical_list.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class AttendanceTodayList extends StatelessWidget {
  final List<Attendance>? attendances;

  const AttendanceTodayList({super.key, required this.attendances});

  @override
  Widget build(BuildContext context) {
    if (attendances == null || attendances!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada data.'),
      );
    }

    return GlobalVerticalPaginatedList(
      itemCount: attendances!.length,
      itemsPerPage: 5,
      spacing: 12,
      itemBuilder: (context, index) {
        final item = attendances![index];
        final name = item.employee?.name ?? '-';
        final time = item.clockIn ?? '-';
        final photo = item.employee?.photo;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: photo != null ? NetworkImage(photo) : null,
                child: photo == null ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, overflow: TextOverflow.ellipsis),
                    Text('Masuk: $time',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
