import 'dart:typed_data';
import 'package:flutter/material.dart';

class EmployeeAttendanceListItem extends StatelessWidget {
  final String name;
  final String nip;
  final Uint8List? photoBytes;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const EmployeeAttendanceListItem({
    super.key,
    required this.name,
    required this.nip,
    required this.photoBytes,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: photoBytes != null ? MemoryImage(photoBytes!) : null,
          child: photoBytes == null ? const Icon(Icons.person, color: Colors.grey, size: 30) : null,
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("NIP: $nip"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
