import 'package:flutter/material.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class ScheduleSection extends StatelessWidget {
  final List<Schedule>? schedules;

  const ScheduleSection({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    if (schedules == null || schedules!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada jadwal kerja hari ini.', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: schedules!.map((schedule) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.login, color: Colors.green),
                    const SizedBox(height: 4),
                    const Text('Masuk', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(schedule.startTime ?? '-', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.logout, color: Colors.red),
                    const SizedBox(height: 4),
                    const Text('Pulang', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(schedule.endTime ?? '-', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
