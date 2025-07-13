import 'package:flutter/material.dart';

enum SnackBarType { success, error, info, pending }

void showAppSnackBar(
  BuildContext context,
  String message, {
  SnackBarType type = SnackBarType.info,
  Duration duration = const Duration(seconds: 3),
}) {
  final color = {
    SnackBarType.success: Colors.green,
    SnackBarType.error: Colors.redAccent,
    SnackBarType.info: Colors.blue,
    SnackBarType.pending: Colors.grey
  }[type]!;

  final icon = {
    SnackBarType.success: Icons.check_circle,
    SnackBarType.error: Icons.error_outline,
    SnackBarType.info: Icons.info_outline,
    SnackBarType.pending: Icons.access_time
  }[type]!;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: duration,
    ),
  );
}
