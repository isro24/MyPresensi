import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/extension/int_ext.dart';
import 'package:my_presensi/presentation/employee/dashboard/bloc/employee_dashboard_bloc.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/dashboard_card.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/working_timer.dart';

class DashboardEmployeeScreen extends StatefulWidget {
  const DashboardEmployeeScreen({super.key});

  @override
  State<DashboardEmployeeScreen> createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployeeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(GetDashboardDataEvent());
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.white,
    body: BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoaded) {
          final data = state.dashboard.data;
          final attendance = data.attendance;
          return Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.only(top: 58, left: 16, right: 16),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang, ${data.name.split(' ').first} 👋',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.go('/employee/profile');
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey.shade200,
                                      backgroundImage: data.photo.isNotEmpty
                                          ? NetworkImage(data.photo)
                                          : null,
                                      child: data.photo.isEmpty
                                          ? Icon(Icons.person, size: 28, color: AppColors.grey)
                                          : null,
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          data.position,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              StreamBuilder<DateTime>(
                                stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
                                initialData: DateTime.now(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return const SizedBox.shrink();
                                  final now = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(now.formatTanggal, style: const TextStyle(fontSize: 14)),
                                      const SizedBox(height: 4),
                                      Text(now.formatJam, style: const TextStyle(fontSize: 14)),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                      ),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Absen Masuk', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Absen Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              Text(
                                attendance?.clockIn?.toString().substring(11, 19) ?? '--:--:--',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                attendance?.clockOut?.toString().substring(11, 19) ?? '--:--:--',
                                style: const TextStyle(fontSize: 18),
                              ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            if (attendance?.clockIn != null && attendance?.clockOut == null)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: WorkingTimer(
                                  endTimeString: data.schedule?.endTime, 
                                ),
                              ),

                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      context.go('/employee/attendance/in');
                                    },
                                    icon: const Icon(Icons.login),
                                    label: const Text("Clock In"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      context.go('/employee/attendance/out');
                                    },
                                    icon: const Icon(Icons.logout),
                                    label: const Text("Clock Out"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      if (data.schedule != null) ...[
                        Text(
                          'Jam Kerja :',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Masuk: ${data.schedule!.startTime.formatJamWIB}  |  Pulang: ${data.schedule!.endTime.formatJamWIB}',
                          style: const TextStyle(fontSize: 14, color: AppColors.grey),
                        ),
                      ],

                      const SizedBox(height: 4),

                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                        children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 70, 
                              height: 70,
                              child: DashboardCard(icon: Icons.note_alt, onTap: () {}),
                            ),
                            const SizedBox(height: 4),
                            const Text('Izin', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 70, 
                              height: 70,
                              child: DashboardCard(icon: Icons.av_timer, onTap: () {}),
                            ),
                            const SizedBox(height: 4),
                            const Text('Lembur', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 70, 
                              height: 70,
                              child: DashboardCard(icon: Icons.history_edu, onTap: () {}),
                            ),
                            const SizedBox(height: 4),
                            const Text('Riwayat Izin', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is DashboardError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

}
