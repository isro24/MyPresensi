import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onMenuSelected;
  final VoidCallback? onNotificationTap;
  final String? backRoute;

  const ProfileAppBar({
    super.key,
    this.onMenuSelected,
    this.onNotificationTap,
    this.backRoute,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Profil Pegawai',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (backRoute != null) {
            context.go(backRoute!);
          } else {
            context.pop();
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: onNotificationTap ?? () {},
        ),
      ],
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
