import 'package:flutter/material.dart';

class AttendanceDetailInfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const AttendanceDetailInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ),
          Expanded(
            child: Text(value?.isNotEmpty == true ? value! : "-", style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
