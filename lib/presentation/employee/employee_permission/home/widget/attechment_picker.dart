import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_presensi/core/constants/colors.dart';

class AttachmentPicker extends StatelessWidget {
  final File? file;
  final ValueChanged<File?> onFilePicked;

  const AttachmentPicker({
    super.key,
    required this.file,
    required this.onFilePicked,
  });

  Future<void> _pickAttachment(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final path = result.files.single.path;
        if (path != null) {
          onFilePicked(File(path));
        }
      }
    } catch (e) {
      debugPrint("File pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickAttachment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.attach_file, size: 18, color: AppColors.white),
              label: const Text('Pilih File', style: TextStyle(color: AppColors.white)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                file != null ? file!.path.split('/').last : 'Belum ada lampiran',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
