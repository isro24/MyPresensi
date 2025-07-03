import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_presensi/core/components/custome_crud_app_bar.dart';
import 'package:my_presensi/presentation/admin/profile/update/widget/update_profile_form.dart';

class AdminUpdateProfileScreen extends StatefulWidget {
  const AdminUpdateProfileScreen({super.key});

  @override
  State<AdminUpdateProfileScreen> createState() => _AdminUpdateProfileScreenState();
}

class _AdminUpdateProfileScreenState extends State<AdminUpdateProfileScreen> {
  File? imageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: const CustomeCrudAppBar(title: 'Edit Profil'),
      body: AdminUpdateProfileForm(
        imageFile: imageFile,
        onPickImage: _pickImage,
      ),
    );
  }
}
