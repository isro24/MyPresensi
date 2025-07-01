import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/presentation/employee/attendance/bloc/attendance_bloc/employee_attendance_bloc.dart';
import 'package:my_presensi/presentation/employee/attendance/widget/map_preview.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  final bool isClockIn;

  const EmployeeAttendanceScreen({super.key, required this.isClockIn});

  @override
  State<EmployeeAttendanceScreen> createState() => _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceBloc>().add(LoadCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.isClockIn ? 'Clock In' : 'Clock Out',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/employee/dashboard'),
        ),
        elevation: 2,
      ),
      body: BlocConsumer<EmployeeAttendanceBloc, EmployeeAttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
          showAppSnackBar(context, "Presensi berhasil", type: SnackBarType.success);

            context.go('/employee/dashboard');
          } else if (state is AttendanceFailure || state is AttendanceShowError) {
            final message = (state as dynamic).message;
              showAppSnackBar(context, message, type: SnackBarType.error);
          }
        },
        builder: (context, state) {
          final image = (state is AttendanceLoaded) ? state.imageFile : null;
          final isSubmitting = state is AttendanceLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state is AttendanceLoaded && state.latitude != null && state.longitude != null) ...[
                  MapPreview(
                    latitude: state.latitude!,
                    longitude: state.longitude!,
                    address: state.address,
                  ),
                  const SizedBox(height: 24),
                ],
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<EmployeeAttendanceBloc>().add(PickCameraPhoto(context));
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: image != null
                          ? CircleAvatar(radius: 78, backgroundImage: FileImage(image))
                          : const Icon(Icons.camera_alt, size: 36, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (widget.isClockIn)
                  TextField(
                    controller: noteController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Catatan (Opsional)',
                      prefixIcon: const Icon(Icons.edit_note),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                context.read<EmployeeAttendanceBloc>().add(
                                      SubmitAttendance(
                                        isClockIn: widget.isClockIn,
                                        note: noteController.text,
                                        context: context,
                                      ),
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 5,
                        ),
                        child: isSubmitting
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(widget.isClockIn ? Icons.login : Icons.logout, color: Colors.white),
                                  const SizedBox(width: 12),
                                  Text(
                                    widget.isClockIn ? "Clock In" : "Clock Out",
                                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
