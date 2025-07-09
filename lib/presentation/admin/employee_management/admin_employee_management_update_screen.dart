import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/data/models/request/admin/admin_employee_management_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_employee_management_response_model.dart';
import 'package:my_presensi/presentation/admin/employee_management/bloc/admin_employee_management_bloc.dart';

class AdminEmployeeUpdateScreen extends StatefulWidget {
  final int id;
  const AdminEmployeeUpdateScreen({super.key, required this.id});

  @override
  State<AdminEmployeeUpdateScreen> createState() => _AdminEmployeeUpdateScreenState();
}

class _AdminEmployeeUpdateScreenState extends State<AdminEmployeeUpdateScreen> {
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
  EmployeeManagementData? employee;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedPhoto = File(picked.path);
      });
    }
  }

  void loadInitialData() {
    final state = context.read<AdminEmployeeManagementBloc>().state;
    if (state is AdminEmployeeManagementLoaded) {
      employee = state.employees.firstWhere((e) => e.id == widget.id);

      nameController.text = employee?.name ?? '';
      emailController.text = employee?.email ?? '';
      nipController.text = employee?.employee?.nip ?? '';
      positionController.text = employee?.employee?.position ?? '';
      departmentController.text = employee?.employee?.department ?? '';
      phoneController.text = employee?.employee?.phone ?? '';
      addressController.text = employee?.employee?.address ?? '';
      selectedGender = employee?.employee?.gender;
    }
  }

  void submit() {
    final model = EmployeeManagementRequestModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text.isNotEmpty ? passwordController.text : null,
      nip: nipController.text,
      position: positionController.text,
      department: departmentController.text,
      phone: phoneController.text,
      address: addressController.text,
      gender: selectedGender,
      photo: selectedPhoto?.path,
    );

    context.read<AdminEmployeeManagementBloc>().add(
          UpdateEmployee(id: widget.id, model: model),
        );

    context.read<AdminEmployeeManagementBloc>().add(LoadAllEmployees());
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminEmployeeManagementBloc, AdminEmployeeManagementState>(
      listener: (context, state) {
        if (state is UpdateEmployeeSuccess) {
          context.pop(); 
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomeCrudAppBar(title: 'Edit Karyawan'),
        body: employee == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
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
                                  : (employee?.employee?.photo != null
                                      ? NetworkImage(employee!.employee!.photo!)
                                      : null) as ImageProvider?,
                              child: (selectedPhoto == null && employee?.employee?.photo == null)
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
                      const SizedBox(height: 20),
                      CustomTextField(controller: nameController, label: 'Nama'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: emailController, label: 'Email'),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: passwordController,
                        label: 'Password (kosongkan jika tidak diubah)',
                        obscureText: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(controller: nipController, label: 'NIP'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: positionController, label: 'Jabatan'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: departmentController, label: 'Departemen'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: phoneController, label: 'No. HP'),
                      const SizedBox(height: 12),
                      CustomTextField(controller: addressController, label: 'Alamat', maxLines: 2),
                      const SizedBox(height: 12),
                      CustomDropdownFormField<String>(
                        label: 'Jenis Kelamin',
                        value: selectedGender,
                        onChanged: (value) => setState(() => selectedGender = value),
                        items: const [
                          DropdownMenuItem(value: 'Laki-Laki', child: Text('Laki-Laki')),
                          DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Button.filled(
                        onPressed: submit,
                        label: 'Simpan',
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
