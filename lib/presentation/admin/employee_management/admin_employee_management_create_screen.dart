import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/data/models/request/admin/admin_employee_management_request_model.dart';
import 'package:my_presensi/presentation/admin/employee_management/bloc/admin_employee_management_bloc.dart';

class AdminEmployeeCreateScreen extends StatefulWidget {
  const AdminEmployeeCreateScreen({super.key});

  @override
  State<AdminEmployeeCreateScreen> createState() => _AdminEmployeeCreateScreenState();
}

class _AdminEmployeeCreateScreenState extends State<AdminEmployeeCreateScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nipController = TextEditingController();
  final positionController = TextEditingController();
  final departmentController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String? selectedGender;
  File? selectedPhoto;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedPhoto = File(picked.path);
      });
    }
  }

  void submit() {
    final isValid = formKey.currentState!.validate();

    setState(() {}); 

    if (selectedPhoto == null) {
      showAppSnackBar(context, 'Foto wajib dipilih', type: SnackBarType.error);
      return;
    }

    if (isValid) {
      final model = EmployeeManagementRequestModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        nip: nipController.text,
        position: positionController.text,
        department: departmentController.text,
        phone: phoneController.text,
        address: addressController.text,
        gender: selectedGender,
        photo: selectedPhoto?.path,
      );

      context.read<AdminEmployeeManagementBloc>().add(CreateEmployee(model));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomeCrudAppBar(title: 'Tambah Karyawan'),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.grey200,
                      backgroundImage: selectedPhoto != null
                          ? FileImage(selectedPhoto!)
                          : null,
                      child: selectedPhoto == null
                          ? const Icon(Icons.person, size: 50, color: AppColors.grey)
                          : null,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceHeight(20.0),

              CustomTextField(
                controller: nameController,
                label: 'Nama',
                validator: 'Nama wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: 'Email wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: true,
                validator: 'Password wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: nipController,
                label: 'NIP',
                validator: 'NIP wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: positionController,
                label: 'Jabatan',
                validator: 'Jabatan wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: departmentController,
                label: 'Departemen',
                validator: 'Jabatan wajib diisi',
              ),
              const SpaceHeight(12.0),
              CustomTextField(
                controller: phoneController,
                label: 'No. HP',
                validator: 'No. HP wajib diisi',
                keyboardType: TextInputType.phone,
              ),
              
              const SpaceHeight(12.0),
              CustomDropdownFormField<String>(
                label: 'Jenis Kelamin',
                value: selectedGender,
                onChanged: (val) => setState(() => selectedGender = val),
                items: const [
                  DropdownMenuItem(value: 'Laki-Laki', child: Text('Laki-Laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                validator: (value) => value == null ? 'Jenis Kelamin Wajib dipilih' : null,
              ),

              const SpaceHeight(12.0),
              CustomTextField(
                controller: addressController,
                label: 'Alamat',
                maxLines: 2,
                validator: 'Alamat wajib diisi',
              ),
              const SpaceHeight(16.0),
            
              Button.filled(
                onPressed: submit,
                label: 'Simpan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
