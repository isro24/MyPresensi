import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/data/models/response/employee/employee_attendance_response_model.dart';
import 'package:intl/intl.dart';
import 'package:my_presensi/presentation/employee/attendance_history/pages/detail/widget/attendance_image_column.dart';
import 'package:my_presensi/presentation/employee/attendance_history/pages/detail/widget/attendance_info_row.dart';

class EmployeeAttendanceDetailScreen extends StatelessWidget {
  final Data attendance;

  const EmployeeAttendanceDetailScreen({super.key, required this.attendance});

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return "-";
    return DateFormat("EEEE, dd MMMM yyyy", 'id_ID').format(dateTime.toLocal());
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return "-";
    return DateFormat("HH:mm", 'id_ID').format(dateTime.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Presensi", style: TextStyle(color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AttendanceInfoRow(label: "Nama", value: attendance.name),
                AttendanceInfoRow(label: "NIP", value: attendance.nip),
                AttendanceInfoRow(label: "Lokasi", value: attendance.location),
                AttendanceInfoRow(label: "Tanggal", value: _formatDate(attendance.clockIn)),
                AttendanceInfoRow(label: "Jam Masuk", value: _formatTime(attendance.clockIn)),
                AttendanceInfoRow(label: "Jam Pulang", value: _formatTime(attendance.clockOut)),
                AttendanceInfoRow(label: "Status", value: attendance.status),
                AttendanceInfoRow(label: "Catatan", value: attendance.note),
                const SizedBox(height: 24),
                const Text(
                  "Foto Presensi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: AttendanceImageColumn(label: "Masuk", imageBytes: attendance.photoClockInBytes)),
                    const SizedBox(width: 20),
                    Expanded(child: AttendanceImageColumn(label: "Pulang", imageBytes: attendance.photoClockOutBytes)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
