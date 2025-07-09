import 'package:flutter/material.dart';
import 'package:my_presensi/core/extension/int_ext.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_attendance_response_model.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/detail/widget/attendance_detail_info_row.dart';
import 'package:my_presensi/presentation/admin/employee_attendance/detail/widget/attendance_detail_photo_column.dart';

class AdminEmployeeAttendanceDetailScreen extends StatelessWidget {
  final EmployeeAttendanceData attendance;

  const AdminEmployeeAttendanceDetailScreen({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomeCrudAppBar(title: 'Detail Kehadiran Karyawan'),
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
                AttendanceDetailInfoRow(label: "Nama", value: attendance.name),
                AttendanceDetailInfoRow(label: "NIP", value: attendance.nip),
                AttendanceDetailInfoRow(label: "Lokasi", value: attendance.location),
                AttendanceDetailInfoRow(
                  label: "Tanggal",
                  value: attendance.clockIn?.formatTanggal ?? "-",
                ),
                AttendanceDetailInfoRow(
                  label: "Jam Masuk",
                  value: attendance.clockIn?.formatJam ?? "-",
                ),
                AttendanceDetailInfoRow(
                  label: "Jam Pulang",
                  value: attendance.clockOut?.formatJam ?? "-",
                ),
                AttendanceDetailInfoRow(label: "Status", value: attendance.status),
                AttendanceDetailInfoRow(label: "Catatan", value: attendance.note),
                const SizedBox(height: 24),
                const Text(
                  "Foto Presensi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AttendanceDetailPhotoColumn(
                        label: "Masuk",
                        imageBytes: attendance.photoClockInBytes,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AttendanceDetailPhotoColumn(
                        label: "Pulang",
                        imageBytes: attendance.photoClockOutBytes,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
