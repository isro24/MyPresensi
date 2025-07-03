import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/extension/int_ext.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'attendance_image_card.dart'; 

class AttendanceHistoryItem extends StatelessWidget {
  final Data data;

  const AttendanceHistoryItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/employee/attendance/detail', extra: data);
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.blue.withOpacity(0.2),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.clockIn?.formatTanggal ?? "-",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: AttendanceImageCard(label: "Masuk", imageBytes: data.photoClockInBytes)),
                  const SizedBox(width: 16),
                  Expanded(child: AttendanceImageCard(label: "Pulang", imageBytes: data.photoClockOutBytes)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.login, size: 18, color: Colors.green),
                      const SizedBox(width: 4),
                      Text("Masuk: ${data.clockIn?.formatJam ?? '-'}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.logout, size: 18, color: Colors.red),
                      const SizedBox(width: 4),
                      Text("Pulang: ${data.clockOut?.formatJam ?? '-'}"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
