import 'package:flutter/material.dart';

class StatCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const StatCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(title, style: const TextStyle(fontSize: 13)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
