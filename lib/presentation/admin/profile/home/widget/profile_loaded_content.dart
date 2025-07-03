import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/data/models/response/admin/admin_profile_response_model.dart';
import 'package:my_presensi/presentation/auth/widget/logout_dialog.dart';
import 'package:my_presensi/presentation/widget/profile_item.dart';

class AdminProfileLoadedContent extends StatelessWidget {
  final AdminProfileData data;

  const AdminProfileLoadedContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: data.photo.isNotEmpty ? NetworkImage(data.photo) : null,
            child: data.photo.isEmpty
                ? const Icon(Icons.person, size: 50, color: AppColors.grey)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            data.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(data.position, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () => context.push('/admin/profile/edit'),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 16),
                SizedBox(width: 8),
                Text("Edit Profil"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ProfileItem(title: "Email", value: data.email, icon: Icons.email),
                  ProfileItem(title: "Nomor Telepon", value: data.phone, icon: Icons.phone),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.black54),
            title: const Text('Ubah Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push('/admin/change_password'),
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
            onTap: () => showLogoutDialog(context),
          ),
        ],
      ),
    );
  }
}
