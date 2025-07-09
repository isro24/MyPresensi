import 'package:flutter/material.dart';
import 'package:my_presensi/core/constants/colors.dart';

class CustomeProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function(String)? onMenuSelected;
  final VoidCallback? onNotificationTap;

  const CustomeProfileAppBar({
    super.key,
    required this.title,
    this.onMenuSelected,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: onNotificationTap ?? () {},
        ),
      ],
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
