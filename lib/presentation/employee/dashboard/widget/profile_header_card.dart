import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/extension/int_ext.dart';

class ProfileHeaderCard extends StatelessWidget {
  final dynamic data;

  const ProfileHeaderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            InkWell(
              onTap: () => context.go('/employee/profile'),
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: data.photo.isNotEmpty ? NetworkImage(data.photo) : null,
                    child: data.photo.isEmpty
                        ? const Icon(Icons.person, size: 28, color: AppColors.grey)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(data.position, style: const TextStyle(fontSize: 14, color: AppColors.black)),
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
    );
  }
}
