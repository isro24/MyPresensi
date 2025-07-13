import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/stat_card_item.dart';

class StatCards extends StatelessWidget {
  final AdminDashboardData data;

  const StatCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StatCardItem(
              icon: Icons.people,
              title: 'Presensi',
              value: '${data.attendanceTodayCount} orang',
              color: Colors.green,
            ),
            const SizedBox(width: 12),
            StatCardItem(
              icon: Icons.person_off,
              title: 'Tidak Hadir',
              value: '${data.absentCount ?? 0} orang',
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            StatCardItem(
              icon: Icons.alarm,
              title: 'Terlambat',
              value: '${data.lateCount ?? 0} orang',
              color: Colors.orange,
            ),
            const SizedBox(width: 12),
            StatCardItem(
              icon: Icons.location_on,
              title: 'Lokasi Aktif',
              value: '${data.activeLocations?.length ?? 0}',
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
