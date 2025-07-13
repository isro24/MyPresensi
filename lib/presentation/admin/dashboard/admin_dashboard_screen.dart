import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/presentation/admin/dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/absent_employee_list.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/active_location_list.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/admin_card.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/all_location_section.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/attendance_today_list.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/late_employee_list.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/pending_permission_list.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/schedule_sction.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/section_container.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/stat_cards.dart';
import 'package:my_presensi/presentation/admin/dashboard/widget/weekly_attendance_chart.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final ScrollController _scrollController = ScrollController();
  double _headerOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    context.read<AdminDashboardBloc>().add(GetAdminDashboardEvent());

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      double newOpacity = 1.0 - (offset / 80.0);
      newOpacity = newOpacity.clamp(0.0, 1.0);

      if (newOpacity != _headerOpacity) {
        setState(() {
          _headerOpacity = newOpacity;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
          builder: (context, state) {
            if (state is AdminDashboardLoaded) {
              final name = state.data.admin?.name?.split(' ').first ?? 'Admin';
              return Text(
                'Selamat datang, $name 👋',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
            return const Text(
              'Dashboard Admin',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 65 * _headerOpacity,
            curve: Curves.easeOut,
            child: Opacity(
              opacity: _headerOpacity,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
              ),
            ),
          ),
          BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
            builder: (context, state) {
              if (state is AdminDashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AdminDashboardError) {
                return ErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<AdminDashboardBloc>().add(GetAdminDashboardEvent());
                  },
                );
              }

              if (state is AdminDashboardLoaded) {
                final data = state.data;

                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdminCard(data: data),
                      const SizedBox(height: 16),
                      StatCards(data: data),
                      const SizedBox(height: 24),
                      SectionContainer(
                        title: 'Jadwal Kerja Hari Ini',
                        child: ScheduleSection(schedules: data.schedules),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Grafik Kehadiran Mingguan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      WeeklyAttendanceChart(data: data.weeklyAttendance),
                      const SizedBox(height: 24),
                      SectionContainer(
                        title: 'Aktivitas Presensi Hari Ini',
                        child: AttendanceTodayList(attendances: data.attendancesToday),
                      ),
                      const SizedBox(height: 16),
                      SectionContainer(
                        title: 'Pegawai Terlambat',
                        child: LateEmployeeList(employees: data.lateEmployees),
                      ),
                      const SizedBox(height: 16),
                      SectionContainer(
                        title: 'Pegawai Tidak Hadir',
                        child: AbsentEmployeeList(employees: data.absentEmployees),
                      ),
                      const SizedBox(height: 16),
                      SectionContainer(
                        title: 'Lokasi Aktif',
                        child: ActiveLocationList(locations: data.activeLocations),
                      ),
                      AllLocationSection(locations: data.locations),
                      const SizedBox(height: 16),
                      SectionContainer(
                        title: 'Izin Menunggu Persetujuan',
                        child: PendingPermissionList(list: data.pendingPermissions),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
