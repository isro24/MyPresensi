import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/presentation/employee/attendance_history/bloc/attendance_history_bloc.dart';
import 'package:my_presensi/presentation/employee/attendance_history/pages/home/widget/attendance_history_item.dart';

class EmployeeAttendanceHistoryScreen extends StatefulWidget {
  const EmployeeAttendanceHistoryScreen({super.key});

  @override
  State<EmployeeAttendanceHistoryScreen> createState() => _EmployeeAttendanceHistoryScreenState();
}

class _EmployeeAttendanceHistoryScreenState extends State<EmployeeAttendanceHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceHistoryBloc>().add(LoadAttendanceHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Riwayat Presensi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<EmployeeAttendanceHistoryBloc, AttendanceHistoryState>(
        builder: (context, state) {
          if (state is AttendanceHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceHistoryLoaded) {
            if (state.history.isEmpty) {
              return const Center(child: Text("Belum ada data presensi"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                return AttendanceHistoryItem(data: state.history[index]);
              },
            );
          } else if (state is AttendanceHistoryError) {
            return Center(child: Text("Gagal memuat: ${state.message}"));
          }
          return const Center(child: Text("Data belum dimuat."));
        },
      ),
    );
  }
}
