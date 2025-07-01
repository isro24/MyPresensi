import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/models/request/employee/employee_profile_request_model.dart';
import 'package:my_presensi/presentation/employee/profile/bloc/employee_profile_bloc.dart';


class EmployeeUpdateProfileScreen extends StatefulWidget {
  const EmployeeUpdateProfileScreen({super.key});

  @override
  State<EmployeeUpdateProfileScreen> createState() => _EmployeeUpdateProfileScreenState();
}
class _EmployeeUpdateProfileScreenState extends State<EmployeeUpdateProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final nipController = TextEditingController();
  final positionController = TextEditingController();
  final genderController = TextEditingController();

  
  String? photo;
  File? imageFile;

  @override
  void initState() {
    super.initState();

    final state = context.read<EmployeeProfileBloc>().state;
    if (state is EmployeeProfileLoaded || state is EmployeeProfileUpdated) {
      final profile = (state is EmployeeProfileLoaded)
          ? state.profile
          : (state as EmployeeProfileUpdated).profile;

      phoneController.text = profile.data.phone;
      addressController.text = profile.data.address;
      photo = profile.data.photo;

      nameController.text = profile.data.name;
      emailController.text = profile.data.email;
      nipController.text = profile.data.nip;
      positionController.text = profile.data.position;
      genderController.text = profile.data.gender;
    }
  }


  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void _submitUpdate() {
    if (formKey.currentState!.validate()) {
      final state = context.read<EmployeeProfileBloc>().state;
      if (state is EmployeeProfileLoaded) {
        final id = state.profile.data.id;
        final oldPhone = state.profile.data.phone;
        final oldAddress = state.profile.data.address;

        final newPhone = phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : oldPhone;

        final newAddress = addressController.text.trim().isNotEmpty
            ? addressController.text.trim()
            : oldAddress;

        final request = EmployeeProfileRequestModel(
          phone: newPhone,
          address: newAddress,
        );

        context.read<EmployeeProfileBloc>().add(
          UpdateEmployeeProfileEvent(
            id: id,
            request: request,
            photoFile: imageFile,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Edit Profil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<EmployeeProfileBloc, EmployeeProfileState>(
        listener: (context, state) {
          if (state is EmployeeProfileUpdated) {
          showAppSnackBar(context, "Profil berhasil diperbarui", type: SnackBarType.success);
            context.read<EmployeeProfileBloc>().add(GetEmployeeProfileEvent());

            Future.delayed(const Duration(milliseconds: 700), () {
              if (context.mounted) context.go("/employee/profile");
            });
          }
         else if (state is EmployeeProfileUpdateError) {

          showAppSnackBar(context, state.message, type: SnackBarType.error);

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) {
              context.read<EmployeeProfileBloc>().add(ResetEmployeeProfileStateEvent());
            }
          });
        }

        },
        builder: (context, state) {
          final isLoading = state is EmployeeProfileUpdating;
            final profile = (state is EmployeeProfileLoaded)
              ? state.profile
              : (state is EmployeeProfileUpdated)
                  ? state.profile
                  : null;

          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: imageFile != null
                              ? FileImage(imageFile!)
                              : (photo != null && photo!.isNotEmpty
                                  ? NetworkImage(photo!)
                                  : null) as ImageProvider?,
                          child: (imageFile == null && (photo == null || photo!.isEmpty))
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
                  
                  CustomTextField(
                    controller: nameController,
                    label: 'Nama',
                    validator: '', 
                    readOnly: true,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    validator: '',
                    readOnly: true,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: nipController,
                    label: 'NIP',
                    validator: '',
                    readOnly: true,
                    prefixIcon: const Icon(Icons.badge),
                  ),
                  const SizedBox(height: 10),

                  CustomTextField(
                    controller: positionController,
                    label: 'Jabatan',
                    validator: '',
                    readOnly: true,
                    prefixIcon: const Icon(Icons.work),
                  ),

                  const SizedBox(height: 10),
                  
                  CustomTextField(
                    controller: genderController,
                    label: 'Jenis Kelamin',
                    validator: '',
                    readOnly: true,
                    prefixIcon: const Icon(Icons.wc),
                  ),

                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: phoneController,
                    label: 'Nomor Telepon',
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: addressController,
                    label: 'Alamat',
                    prefixIcon: const Icon(Icons.home),
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitUpdate,
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
      ),
    );
  }
}