import 'package:flutter/material.dart';

class EmptyDataView extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyDataView({
    super.key,
    this.message = 'Tidak ada data ditemukan.',
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
