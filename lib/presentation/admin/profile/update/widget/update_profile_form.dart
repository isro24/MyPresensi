import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/models/request/admin/admin_profile_request_model.dart';
import 'package:my_presensi/presentation/admin/profile/bloc/admin_profile_bloc.dart';

class AdminUpdateProfileForm extends StatefulWidget {
  final File? imageFile;
  final VoidCallback onPickImage;

  const AdminUpdateProfileForm({
    super.key,
    required this.imageFile,
    required this.onPickImage,
  });

  @override
  State<AdminUpdateProfileForm> createState() => _AdminUpdateProfileFormState();
}

class _AdminUpdateProfileFormState extends State<AdminUpdateProfileForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final phoneController = TextEditingController();

  String? photoUrl;

  @override
  void initState() {
    super.initState();
    final state = context.read<AdminProfileBloc>().state;
    if (state is AdminProfileLoaded || state is AdminProfileUpdated) {
      final profile = (state is AdminProfileLoaded ? state.profile : (state as AdminProfileUpdated).profile);
      nameController.text = profile.data.name;
      emailController.text = profile.data.email;
      positionController.text = profile.data.position;
      phoneController.text = profile.data.phone;
      photoUrl = profile.data.photo;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    positionController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      final state = context.read<AdminProfileBloc>().state;
      if (state is AdminProfileLoaded) {
        final id = state.profile.data.id;
        final request = AdminProfileRequestModel(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          position: positionController.text.trim(),
          phone: phoneController.text.trim(),
        );
        context.read<AdminProfileBloc>().add(
              UpdateAdminProfileEvent(id: id, request: request, photoFile: widget.imageFile),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminProfileBloc, AdminProfileState>(
      listener: (context, state) {
        if (state is AdminProfileUpdated) {
          showAppSnackBar(context, "Profil berhasil diperbarui", type: SnackBarType.success);
          context.read<AdminProfileBloc>().add(GetAdminProfileEvent());
          Future.delayed(const Duration(milliseconds: 700), () {
            if (context.mounted) context.go("/admin/profile");
          });
        } else if (state is AdminProfileUpdateError) {
          showAppSnackBar(context, state.message, type: SnackBarType.error);
          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              context.read<AdminProfileBloc>().add(ResetAdminProfileStateEvent());
            }
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is AdminProfileUpdating;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: widget.onPickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: widget.imageFile != null
                            ? FileImage(widget.imageFile!)
                            : (photoUrl != null && photoUrl!.isNotEmpty
                                ? NetworkImage(photoUrl!)
                                : null) as ImageProvider?,
                        child: (widget.imageFile == null && (photoUrl == null || photoUrl!.isEmpty))
                            ? const Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  label: 'Nama',
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: positionController,
                  label: 'Jabatan',
                  prefixIcon: const Icon(Icons.work),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  label: 'Nomor Telepon',
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Simpan", style: TextStyle(fontSize: 16, color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
