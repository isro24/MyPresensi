import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/layouts/custome_crud_app_bar.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/presentation/employee/employee_permission/bloc/employee_permission_bloc.dart';
import 'package:my_presensi/presentation/employee/employee_permission/home/widget/attechment_picker.dart';

class EmployeePermissionFormScreen extends StatefulWidget {
  const EmployeePermissionFormScreen({super.key});

  @override
  State<EmployeePermissionFormScreen> createState() => _EmployeePermissionFormScreenState();
}

class _EmployeePermissionFormScreenState extends State<EmployeePermissionFormScreen> {
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final reasonController = TextEditingController();

  String? _selectedType;
  File? _attachmentFile;

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  void _onAttachmentPicked(File? file) {
    setState(() {
      _attachmentFile = file;
    });
  }

  DateTime? _parseDate(String input) {
    try {
      return DateTime.parse(input);
    } catch (_) {
      return null;
    }
  }

  void submit() {
    if (formKey.currentState?.validate() != true) return;

    final fields = {
      'type': _selectedType!,
      'start_date': startDateController.text.trim(),
      'end_date': endDateController.text.trim(),
      'reason': reasonController.text.trim(),
    };

    context.read<EmployeePermissionBloc>().add(
      CreatePermissionEvent(fields: fields, attachmentFile: _attachmentFile),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeItems = const [
      DropdownMenuItem(value: 'izin', child: Text('Izin')),
      DropdownMenuItem(value: 'sakit', child: Text('Sakit')),
      DropdownMenuItem(value: 'cuti', child: Text('Cuti')),
    ];

    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const CustomeCrudAppBar(title: 'Ajukan Izin'),
      body: BlocListener<EmployeePermissionBloc, EmployeePermissionState>(
        listener: (context, state) {
          if (state is EmployeePermissionSuccess) {
            showAppSnackBar(context, state.message, type: SnackBarType.success);
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) context.go('/employee/dashboard');
            });
          } else if (state is EmployeePermissionError) {
            showAppSnackBar(context, state.message, type: SnackBarType.error);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: _inputDecoration('Tipe Izin'),
                  items: typeItems,
                  onChanged: (val) => setState(() => _selectedType = val),
                  validator: (value) => value == null || value.isEmpty ? 'Tipe izin wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                DatePickerFormField(
                  controller: startDateController,
                  label: 'Tanggal Mulai',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Tanggal mulai wajib diisi';
                    if (_parseDate(value) == null) return 'Format tanggal salah';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DatePickerFormField(
                  controller: endDateController,
                  label: 'Tanggal Selesai',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Tanggal selesai wajib diisi';
                    if (_parseDate(value) == null) return 'Format tanggal salah';
                    if (_parseDate(value)!.isBefore(_parseDate(startDateController.text) ?? DateTime.now())) {
                      return 'Tanggal selesai harus setelah tanggal mulai';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: reasonController,
                  decoration: _inputDecoration('Alasan'),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Alasan wajib diisi' : null,
                ),
                const SizedBox(height: 20),

                AttachmentPicker(
                  file: _attachmentFile,
                  onFilePicked: _onAttachmentPicked,
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Ajukan Izin',
                      style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
