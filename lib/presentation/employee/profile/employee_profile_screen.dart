import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/presentation/auth/widget/logout_dialog.dart'; 
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/presentation/employee/profile/bloc/employee_profile_bloc.dart';
import 'package:my_presensi/presentation/employee/profile/widget/profile_app_bar.dart';
import 'package:my_presensi/presentation/employee/profile/widget/profile_item.dart';
import 'package:my_presensi/presentation/employee/profile/widget/stat_attendance.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeProfileBloc>().add(GetEmployeeProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ProfileAppBar(
        onNotificationTap: () => context.push('/notifications'),
      ),
      body: BlocBuilder<EmployeeProfileBloc, EmployeeProfileState>(
        builder: (context, state) {
          if (state is EmployeeProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeProfileLoaded) {
            final data = state.profile.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: data.photo.isNotEmpty ? NetworkImage(data.photo) : null,
                    child: data.photo.isEmpty
                        ? const Icon(Icons.person, size: 50, color: AppColors.grey)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(data.position, style: const TextStyle(fontSize: 16)),
                  Text('NIP: ${data.nip}', style: const TextStyle(color: AppColors.grey)),
                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: () {
                      context.push('/employee/profile/edit');
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, size: 16),
                        SizedBox(width: 8),
                        Text("Edit Profil"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 16,
                        alignment: WrapAlignment.center,        
                        runAlignment: WrapAlignment.center,     
                        crossAxisAlignment: WrapCrossAlignment.center, 
                      children: [
                        StatAttendance(label: "Hadir", value: data.summary.hadir, icon: Icons.check_circle, color: Colors.green),
                        StatAttendance(label: "Telat", value: data.summary.telat, icon: Icons.access_time, color: Colors.orange),
                        StatAttendance(label: "Izin", value: data.summary.izin, icon: Icons.info_outline, color: Colors.blue),
                        StatAttendance(label: "Sakit", value: data.summary.sakit, icon: Icons.healing, color: Colors.indigo),
                        StatAttendance(label: "Alfa", value: data.summary.alfa, icon: Icons.cancel, color: Colors.red),
                        StatAttendance(label: "Cuti", value: data.summary.cuti, icon: Icons.beach_access, color: Colors.teal),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ProfileItem(title: "Email", value: data.email, icon: Icons.email),
                          ProfileItem(title: "Departemen", value: data.department, icon: Icons.apartment),
                          ProfileItem(title: "Jenis Kelamin", value: data.gender, icon: Icons.person_outline),
                          ProfileItem(title: "Nomor Telepon", value: data.phone, icon: Icons.phone),
                          ProfileItem(title: "Alamat", value: data.address, icon: Icons.location_on),
                        ],
                      ),
                    ),
                  ),  
                  const SizedBox(height: 12),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.lock_outline, color: Colors.black54),
                    title: const Text('Ubah Password'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/employee/change_password');
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout', style: TextStyle(color: Colors.red)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                    onTap: () {
                      showLogoutDialog(context);
                    },
                  ),

                ],
              ),
            );
          } else if (state is EmployeeProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Gagal memuat profil'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<EmployeeProfileBloc>().add(GetEmployeeProfileEvent());
                      },
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
