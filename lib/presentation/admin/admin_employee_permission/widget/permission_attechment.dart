import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/service/service_http_client.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class PermissionAttachment extends StatelessWidget {
  final String fileUrl;

  const PermissionAttachment({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    final filename = fileUrl.split('/').last;

    if (fileUrl.endsWith('.jpg') || fileUrl.endsWith('.jpeg') || fileUrl.endsWith('.png')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          fileUrl,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Text("Gagal memuat gambar"),
        ),
      );
    }

    return InkWell(
      onTap: () async {
        try {
          final response = await ServiceHttpClient().getBytesWithToken('admin/permission-file/$filename');
          if (response.statusCode != 200) throw Exception('Gagal mengunduh file');

          final tempDir = await getTemporaryDirectory();
          final filePath = '${tempDir.path}/$filename';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          final result = await OpenFilex.open(file.path);
          if (result.type != ResultType.done) {
            showAppSnackBar(context, "Gagal membuka file lampiran", type: SnackBarType.error);
          }
        } catch (e) {
          debugPrint('File open error: $e');
          showAppSnackBar(context, "Terjadi kesalahan saat membuka lampiran", type: SnackBarType.error);
        }
      },
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: AppColors.primary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              filename,
              style: const TextStyle(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
