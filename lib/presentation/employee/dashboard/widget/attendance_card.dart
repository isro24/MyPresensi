import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/clock_info_card.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/working_timer.dart';

class AttendanceCard extends StatelessWidget {
  final dynamic data;
  final dynamic attendance;

  const AttendanceCard({
    super.key,
    required this.data,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    final clockInTime = attendance?.clockIn?.toString().substring(11, 19) ?? '--:--:--';
    final clockOutTime = attendance?.clockOut?.toString().substring(11, 19) ?? '--:--:--';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status Kehadiran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClockInfoCard(label: 'Clock In', icon: Icons.login, time: clockInTime, color: Colors.green),
              ClockInfoCard(label: 'Clock Out', icon: Icons.logout, time: clockOutTime, color: Colors.red),
            ],
          ),
          const SizedBox(height: 12),
          if (attendance?.clockIn != null && attendance?.clockOut == null)
            if (attendance?.clockIn != null && attendance?.clockOut == null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: WorkingTimer(endTimeString: data.schedule?.endTime),
                ),
              ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/employee/attendance/in'),
                  icon: const Icon(Icons.login),
                  label: const Text("Clock In"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/employee/attendance/out'),
                  icon: const Icon(Icons.logout),
                  label: const Text("Clock Out"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
