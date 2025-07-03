import 'dart:typed_data';
import 'package:flutter/material.dart';

class AttendanceImageColumn extends StatelessWidget {
  final String label;
  final Uint8List? imageBytes;

  const AttendanceImageColumn({
    super.key,
    required this.label,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
            boxShadow: imageBytes != null
                ? [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))]
                : [],
            image: imageBytes != null
                ? DecorationImage(image: MemoryImage(imageBytes!), fit: BoxFit.cover)
                : null,
          ),
          child: imageBytes == null
              ? const Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey))
              : null,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
