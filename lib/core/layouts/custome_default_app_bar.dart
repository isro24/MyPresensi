import 'package:flutter/material.dart';
import 'package:my_presensi/core/constants/colors.dart';

class CustomeDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomeDefaultAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: 
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),      
      centerTitle: false,
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
