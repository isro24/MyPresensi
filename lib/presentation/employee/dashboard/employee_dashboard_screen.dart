import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/extension/int_ext.dart';
import 'package:my_presensi/presentation/employee/dashboard/bloc/employee_dashboard_bloc.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/attendance_card.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/dashboard_menu_card.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/profile_header_card.dart';

class DashboardEmployeeScreen extends StatefulWidget {
  const DashboardEmployeeScreen({super.key});

  @override
  State<DashboardEmployeeScreen> createState() => _DashboardEmployeeScreenState();
}

class _DashboardEmployeeScreenState extends State<DashboardEmployeeScreen> {
  final ScrollController scrollController = ScrollController();
  double headerOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetDashboardDataEvent());

    scrollController.addListener(() {
      final offset = scrollController.offset;
      double newOpacity = 1.0 - (offset / 80.0);
      newOpacity = newOpacity.clamp(0.0, 1.0);

      if (newOpacity != headerOpacity) {
        setState(() {
          headerOpacity = newOpacity;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoaded) {
              final name = state.dashboard.data.name.split(' ').first;
              return Text(
                'Selamat datang, $name 👋',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }
            return const Text(
              'Dashboard Karyawan',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 65 * headerOpacity,
            curve: Curves.easeOut,
            child: Opacity(
              opacity: headerOpacity,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
              ),
            ),
          ),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DashboardError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DashboardBloc>().add(GetDashboardDataEvent());
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }

              if (state is DashboardLoaded) {
                final data = state.dashboard.data;
                final attendance = data.attendance;

                return SingleChildScrollView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeaderCard(data: data),
                      const SizedBox(height: 24),
                      AttendanceCard(data: data, attendance: attendance),
                      const SizedBox(height: 16),
                      if (data.schedule != null)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.schedule, color: AppColors.primary),
                                  SizedBox(width: 8),
                                  Text(
                                    'Jam Kerja',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${data.schedule!.startTime.formatJamWIB} - ${data.schedule!.endTime.formatJamWIB}',
                                style: const TextStyle(fontSize: 14, color: AppColors.grey),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      const DashboardMenuCard(),
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
