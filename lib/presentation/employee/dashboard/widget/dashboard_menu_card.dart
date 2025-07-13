import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/presentation/employee/dashboard/widget/dashboard_menu_item.dart';

class DashboardMenuCard extends StatelessWidget {
  const DashboardMenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
          const Text('Aksi Cepat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
            children: [
              DashboardMenuItem(
                icon: Icons.note_alt,
                label: 'Izin',
                onTap: () => context.go('/employee/permission/form'),
                color: Colors.blue,
              ),
              DashboardMenuItem(
                icon: Icons.av_timer,
                label: 'Lembur',
                onTap: () {},
                color: Colors.deepPurple,
              ),
              DashboardMenuItem(
                icon: Icons.history_edu,
                label: 'Riwayat Izin',
                onTap: () => context.go('/employee/permission/history'),
                color: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
